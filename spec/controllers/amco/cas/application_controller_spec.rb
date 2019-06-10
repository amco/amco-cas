require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    include Amco::Cas::Scope
  end

  let(:cas_base_url) { 'https://id.amcodev.me' }

  before do
    RubyCAS::Filter.setup({
      cas_base_url: cas_base_url
    })
  end

  describe "#current_user" do
    let(:user) { OpenStruct.new(email:  'user@amco.me') }

    context 'with current_user_id in session' do
      before do
        allow(User).to receive(:find).and_return(user)
        session[:current_user_id] = user.email
      end

      it "returns a user instance" do
        expect(controller.send(:current_user)).to eq(user)
      end
    end

    context 'without a current_user_id in session' do
      before do
        session[:current_user_id] = nil
      end

      it { expect(controller.send(:current_user)).to eq(nil) }
    end
  end

  describe '#require_user' do

    context 'with current_user set' do
      let(:user) { OpenStruct.new(email:  'user@amco.me') }

      before do
        allow(User).to receive(:find).and_return(user)
        session[:current_user_id] = user.email
      end

      it { expect(controller.send(:require_user)).to eq(nil) }

    end

    context 'without current_user set' do
      before do
        allow(Amco::Cas::Filter).to receive(:logout).and_return(nil)
        allow(controller).to receive(:log_out).and_return(nil)
      end

      it { expect(controller.send(:require_user)).to eq(false) }
    end
  end

  describe '#log_out' do
    let(:user) { OpenStruct.new(email:  'user@amco.me') }

    before do
      allow(Amco::Cas::Filter).to receive(:logout).and_return(nil)
      allow(User).to receive(:find).and_return(user)
      session[:current_user_id] = user.email
    end

    it 'resets session values' do
      expect do
        controller.send(:log_out)
      end.to change{session[:current_user_id]}.from(user.email).to(nil)
    end
  end
end
