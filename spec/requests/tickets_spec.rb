require 'rails_helper'

RSpec.describe "Tickets Request", type: :request do

  describe 'GET #new' do
    subject { get new_ticket_path(user.id) }
    let!(:user) { create(:user) }
    include_context 'login_as_user'
    it '新規投稿画面に遷移できること' do
      subject
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let!(:user) { create(:user) }
    let(:user_ticket) { create(:ticket, user_id: user.id) }
    include_context 'login_as_user'
    context 'パラメータが正常なとき' do
      it '新規投稿できること' do
        expect do
          post tickets_path, params: { ticket: attributes_for(:ticket) }
        end.to change(Ticket, :count).by(+1)
        expect(response).to redirect_to(tickets_path)
      end
    end
  end

  describe 'GET #index' do
    subject { get tickets_path }
    context 'ログインしているとき' do
      let!(:user) { create(:user) }
      include_context 'login_as_user'
      it '投稿の一覧画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
    end
    context 'ログインしていないとき' do
      it '投稿の一覧画面に遷移できないこと' do
        subject
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'GET #show' do
    subject { get ticket_path(ticket.id) }
    let!(:ticket) { create(:ticket) }
    let!(:user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      it '投稿の詳細画面に遷移できること' do
        subject
        expect(response).to be_successful
      end
    end
    context 'ログインしていないとき' do
      it '投稿の詳細画面に遷移できないこと' do
        subject
        expect(response).to redirect_to(new_login_path)
      end
    end
  end

  describe 'GET #edit' do
    let!(:user) { create(:user) }
    let!(:user_ticket) { create(:ticket, user_id: user.id) }
    let(:other_user_ticket) { create(:ticket) }
    subject { get edit_ticket_path(user_ticket.id) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'ユーザーが自分の場合' do
        it '投稿の編集画面に遷移できること' do
          subject
          expect(response).to be_successful
        end
      end
      context 'ユーザーが自分ではない場合' do
        it '投稿の編集画面に遷移できないこと' do
          other_user_id = user.id + 1
          other_user_ticket
          get edit_ticket_path(other_user_id)
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      it '投稿の編集画面に遷移できないこと' do
        subject
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'PATCH #update' do
    let!(:user) { create(:user) }
    let!(:user_ticket) { create(:ticket, user_id: user.id) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'パラメータが正常な場合' do
        it '投稿内容が更新されること' do
          expect do
            patch ticket_path(user_ticket.id), params: { ticket: {content: "投稿を編集しました"} }
          end.to change { Ticket.find(1).content }
          expect(response).to redirect_to(ticket_path)
        end
      end
      context 'パラメータが不正な場合' do
        it '投稿内容が更新されないこと' do
          expect do
            patch ticket_path(user_ticket.id), params: { ticket: {content: ""} }
          end.not_to change { Ticket.find(1).content }
          expect(response).to be_successful
        end
      end
    end
    context 'ログインしていないとき' do
      it '投稿内容が更新されないこと' do
        expect do
          patch ticket_path(user_ticket.id), params: { ticket: {content: "投稿を編集しました"} }
        end.not_to change { Ticket.find(1).content }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete ticket_path(user_ticket.id) }
    let!(:user) { create(:user) }
    let!(:user_ticket) { create(:ticket, user_id: user.id) }
    let(:other_user) { create(:user) }
    context 'ログインしているとき' do
      include_context 'login_as_user'
      context 'ユーザーが自分の場合' do
        it '投稿の削除ができること' do
          expect { subject }.to change(Ticket, :count).by(-1)
          expect(response).to redirect_to(tickets_path)
        end
      end
      context 'ユーザーが自分ではない場合' do
        it '投稿の削除ができないこと' do
          user_ticket = user.id + 1
          other_user
          expect { subject }.not_to change { user_ticket }
          expect(response).to have_http_status(:redirect)
        end
      end
    end
    context 'ログインしていないとき' do
      it '投稿の削除ができないこと' do
        expect { subject }.not_to change { user_ticket }
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
