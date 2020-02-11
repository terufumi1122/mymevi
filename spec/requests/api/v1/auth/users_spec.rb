require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:current_user) { create(:user) }
  let(:params)       { attributes_for(:user) }

  describe '新規登録出来る' do
    before do
      post(api_user_registration_path, params: params)
    end

    it '200 OKが返ってくる' do
      expect(response.status).to eq(200)
    end

    it 'レスポンスのidと最後に登録されたUserのidが一致する' do
      expect(JSON.parse(response.body)['data']['id']).to eq(User.last.id)
    end

    it 'レスポンスのemailと最後に登録されたUserのemailが一致する' do
      expect(JSON.parse(response.body)['data']['email']).to eq(User.last.email)
    end
  end

  describe '正しいparamsならログイン出来る' do
    before do
      post(api_user_session_path, params: {
             email:    current_user.email,
             password: current_user.password
           })
    end

    it '200 OKが返ってくる' do
      expect(response.status).to eq(200)
    end

    it 'レスポンスヘッダにuidが存在する' do
      expect(response.headers['uid']).to be_present
    end

    it 'レスポンスヘッダにaccess-tokenが存在する' do
      expect(response.headers['access-token']).to be_present
    end

    it 'レスポンスヘッダにclientが存在する' do
      expect(response.headers['client']).to be_present
    end
  end

  describe 'emailを間違えるとログイン出来ない' do
    before do
      post(api_user_session_path, params: {
             email:    'wrong@sample.com',
             password: current_user.password
           })
    end

    it '401 Unauthorizedが返ってくる' do
      expect(response.status).to eq(401)
    end

    it 'レスポンスヘッダにuidが存在しない' do
      expect(response.headers['uid']).to be_blank
    end

    it 'レスポンスヘッダにaccess-tokenが存在しない' do
      expect(response.headers['access-token']).to be_blank
    end

    it 'レスポンスヘッダにclientが存在しない' do
      expect(response.headers['client']).to be_blank
    end
  end

  describe 'passwordを間違えるとログイン出来ない' do
    before do
      post(api_user_session_path, params: {
             email:    current_user.email,
             password: 'wrong-password'
           })
    end

    it '401 Unauthorizedが返ってくる' do
      expect(response.status).to eq(401)
    end

    it 'レスポンスヘッダにuidが存在しない' do
      expect(response.headers['uid']).to be_blank
    end

    it 'レスポンスヘッダにaccess-tokenが存在しない' do
      expect(response.headers['access-token']).to be_blank
    end

    it 'レスポンスヘッダにclientが存在しない' do
      expect(response.headers['client']).to be_blank
    end
  end

  describe 'ログアウト出来る' do
    before do
      post(api_user_session_path, params: {
             email:    current_user.email,
             password: current_user.password
           })
      delete(destroy_api_user_session_path, headers: {
               'uid':          response.headers['uid'],
               'client':       response.headers['client'],
               'access-token': response.headers['access-token']
             })
    end

    it '200 OKが返ってくる' do
      expect(response.status).to eq(200)
    end

    it 'レスポンスボディにsuccessが存在する' do
      expect(response.body['success']).to be_present
    end
  end
end
