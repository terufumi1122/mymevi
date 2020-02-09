require 'rails_helper'

RSpec.describe 'Habits', type: :request do
  let!(:current_user) { create(:user) }
  let!(:user_params)  { attributes_for(:user) }

  let!(:habit_params)  { { params: {
    name: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    best: rand(1..4),
    user_id: current_user.id
  }}}

  describe '習慣が新規登録出来る' do
    before do
      post(api_v1_habits_path, habit_params)
    end

    it '201 Createdが返ってくる' do
      expect(response.status).to eq(201)
    end

    it 'レスポンスのidと最後に登録されたHabitのidが一致する' do
      expect(JSON.parse(response.body)['id']).to eq(Habit.last.id)
    end

    it 'レスポンスのemailと最後に登録されたHabitのnameが一致する' do
      expect(JSON.parse(response.body)['name']).to eq(Habit.last.name)
    end
  end

  describe '習慣が更新出来る' do
    it 'nameの変更が出来る'
    it 'descriptionの変更が出来る'
    it 'location_idの変更が出来る'
    it 'eyecatchの変更が出来る'
  end

  describe '習慣が削除出来る' do
    before do
      post(api_v1_habits_path, habit_params)
      delete("/api/v1/habits/#{JSON.parse(response.body)['id']}")
    end

    it '204 No Contentが返ってくる' do
      expect(response.status).to eq(204)
    end
  end
end