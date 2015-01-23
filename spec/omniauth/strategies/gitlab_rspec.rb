require 'spec_helper'

describe OmniAuth::Strategies::GitLab do
  let(:access_token) { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response) { double('Response', :parsed => parsed_response) }

  let(:gitlab_site)          { 'https://some.other.site.com' }
  let(:gitlab_authorize_url) { '/oauth/authorize/' }
  let(:gitlab_token_url)     { '/oauth/token/' }
  let(:gitlab) do
    OmniAuth::Strategies::GitLab.new('GITLAB_KEY', 'GITLAB_SECRET',
        {
            :client_options => {
                :site => gitlab_site,
                :authorize_url => gitlab_authorize_url,
                :token_url => gitlab_token_url
            }
        }
    )
  end

  subject do
    OmniAuth::Strategies::GitLab.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq("https://gitlab.com")
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth/authorize/')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('/oauth/token/')
    end

    describe "should be overrideable" do
      it "for site" do
        expect(gitlab.options.client_options.site).to eq(gitlab_site)
      end

      it "for authorize url" do
        expect(gitlab.options.client_options.authorize_url).to eq(gitlab_authorize_url)
      end

      it "for token url" do
        expect(gitlab.options.client_options.token_url).to eq(gitlab_token_url)
      end
    end
  end

  context "#email_access_allowed?" do
    it "should not allow email if scope is nil" do
      expect(subject.options['scope']).to be_nil
      expect(subject).not_to be_email_access_allowed
    end

    it "should allow email if scope is user" do
      subject.options['scope'] = 'user'
      expect(subject).to be_email_access_allowed
    end

    it "should allow email if scope is a bunch of stuff including user" do
      subject.options['scope'] = 'public_repo,user,repo,delete_repo,gist'
      expect(subject).to be_email_access_allowed
    end

    it "should not allow email if scope is other than user" do
      subject.options['scope'] = 'repo'
      expect(subject).not_to be_email_access_allowed
    end

    it "should assume email access not allowed if scope is something currently not documented " do
      subject.options['scope'] = 'currently_not_documented'
      expect(subject).not_to be_email_access_allowed
    end
  end

  context "#email" do
    it "should return email from raw_info if available" do
      allow(subject).to receive(:raw_info).and_return({'email' => 'you@example.com'})
      expect(subject.email).to eq('you@example.com')
    end
  end

    it "should return nil if there is no raw_info and email access is not allowed" do
      allow(subject).to receive(:raw_info).and_return({})
      expect(subject.email).to be_nil
    end

  context "#raw_info" do
    it "should use relative paths" do
      expect(access_token).to receive(:get).with('/api/v3/user').and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end

end
