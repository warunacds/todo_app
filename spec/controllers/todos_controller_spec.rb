require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  describe 'POST #create' do
    it 'responds with turbo stream' do
      post :create, params: { todo: { title: 'New Todo' } }, format: :turbo_stream

      expect(response.media_type).to eq Mime[:turbo_stream].to_s
      expect(response.body).to include('turbo-stream')
    end
  end

  describe 'PATCH #update' do
    let(:todo) { Todo.create!(title: 'Old Todo') }

    it 'responds with turbo stream' do
      patch :update, params: { id: todo.id, todo: { title: 'Updated Todo' } }, format: :turbo_stream

      expect(response.media_type).to eq Mime[:turbo_stream].to_s
      expect(response.body).to include('turbo-stream')
    end
  end

  describe 'DELETE #destroy' do
    let!(:todo) { Todo.create!(title: 'Delete Me') }

    it 'responds with turbo stream' do
      delete :destroy, params: { id: todo.id }, format: :turbo_stream

      expect(response.media_type).to eq Mime[:turbo_stream].to_s
      expect(response.body).to include('turbo-stream')
    end
  end
end
