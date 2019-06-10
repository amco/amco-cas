require 'rails_helper'

RSpec.describe Amco::Cas do
  describe 'default setup' do
    let(:cas_base_url)          { 'http://id.amcodev.me' }
    let(:username_session_key)  { 'current_user_id' }
    let(:enable_singe_sign_out) { true }

    let(:default_config) do
      {
        cas_base_url: cas_base_url,
        enable_singe_sign_out: enable_singe_sign_out,
        username_session_key: username_session_key
      }
    end

    describe 'missing arameters' do
      let(:cas_base_url) { nil }

      it 'checks for cas_base_url parameter' do
        expect do
          subject.config(default_config)
        end.to raise_exception(ArgumentError)
      end
    end
  end
end
