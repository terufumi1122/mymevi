require 'rails_helper'

RSpec.describe 'Users', type: :request do

  let(:current_user) { create(:user) }
  let(:params)       { attributes_for(:user) }
  subject            { post(api_user_session_path, params: { email: current_user.email, password: current_user.password })}

  it '新規登録が出来る' do
    post(api_user_registration_path, params: params) #新規登録を行う
    json = JSON.parse(response.body) #HTTPレスポンスを変数に格納
    expect(response.status).to eq(200) #200OKが返ってくる
    expect(json['data']['id']).to eq(User.last.id) #HTTPレスポンスにあるデータと最後に登録されたUserのidが一致するのを確認
    expect(json['data']['email']).to eq(User.last.email) #同様にemailが一致するのを確認
  end

  it 'ログイン出来る' do
    subject
    expect(response.status).to eq(200)
    expect(response.headers['uid']).to be_present
    expect(response.headers['access-token']).to be_present
    expect(response.headers['client']).to be_present
  end

  it 'emailを間違えるとログインできない' do
    post(api_user_session_path, params: {
      email: 'wrong@sample.com',
      password: current_user.password
    })
    expect(response.status).to eq(401)
    expect(response.headers['uid']).to be_blank
    expect(response.headers['access-token']).to be_blank
    expect(response.headers['client']).to be_blank
  end

  it 'passwordを間違えるとログインできない' do
    post(api_user_session_path, params: {
      email: current_user.email,
      password: 'wrong-password'
    })
    expect(response.status).to eq(401)
    expect(response.headers['uid']).to be_blank
    expect(response.headers['access-token']).to be_blank
    expect(response.headers['client']).to be_blank
  end

  it 'ログアウトできる' do
    subject
    delete(destroy_api_user_session_path, headers: {
      'uid':            response.headers['uid'],
      'client':         response.headers['client'],
      'access-token':   response.headers['access-token']
    })
    expect(response.body['success']).to be_truthy
    expect(response.status).to eq(200)
  end
end