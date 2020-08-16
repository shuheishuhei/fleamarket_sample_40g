require 'rails_helper'

describe User do
  describe '#create' do
  #ウィザード形式1ページ目(必須項目は埋まっていないとエラー表示をするか)'
    it "必須項目が間違いなく入力されていれば進める" do
    user = build(:user)
    expect(user).to be_valid
    end

    it "ニックネームが空だと登録できない" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "メールアドレスがないと登録できない" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "パスワードがないと登録できない" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "パスワードは2回入力しないと登録できない" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  
  #ウィザード形式1ページ目(誤入力時のエラー表示がされるか)
    it "すでに登録されているメールアドレスは登録できない" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "メールアドレスが誤入力された（@とドメインを含んでいない）場合は進めない" do
      user = build(:user,email: %w[user@foo..com user_at_foo,org example.user@foo.
        foo@bar_baz.com foo@bar+baz.com])
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it "パスワードが7文字以上でないと進めない" do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      expect(user).to be_valid
    end

    it "パスワードが6文字以下だと登録できない" do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end
  end
end