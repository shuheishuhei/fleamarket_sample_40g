require 'rails_helper'

describe Profile do

  describe '#create_profile' do
  #ウィザード形式2ページ目(必須事項が埋まっていない時にエラー表示をするか)
    it '必須項目が間違いなく入力されていれば進める' do
      user = build(:user)
      profile = build(:profile)
      expect(profile).to be_valid
    end

    it "名前(漢字)が空だと登録できない" do
      profile = build(:profile, first_name: "")
      profile.valid?
      expect(profile.errors[:first_name]).to include("can't be blank", "is invalid")
    end

    it "名字(漢字)が空だと登録できない" do
      profile = build(:profile, family_name: nil)
      profile.valid?
      expect(profile.errors[:family_name]).to include("can't be blank", "is invalid")
    end

    it "名前(かな)が空だと登録できない" do
      profile = build(:profile, first_name_kana: nil)
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("can't be blank", "is invalid")
    end

    it "名字(かな)が空だと登録できない" do
      profile = build(:profile, family_name_kana: nil)
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("can't be blank", "is invalid")
    end

    it "生年月日が入力されていないと進めない" do
      profile = build(:profile, birthday: nil)
      profile.valid?
      expect(profile.errors[:birthday]).to include("can't be blank")
    end

  #ウィザード形式2ページ目(誤入力時のエラー表示がされるか)
    it "名前が全角入力されていないと進めない(アルファベットver)" do
      profile = build(:profile, first_name: "hanako")
      profile.valid?
      expect(profile.errors[:first_name]).to include("is invalid")
    end 
    it "名字が全角で入力されていないと進めない(半角ｶﾀｶﾅver)" do
      profile = build(:profile,first_name: "ﾊﾅｺ")
      profile.valid?
      expect(profile.errors[:first_name]).to include()
    end

    it "名字が全角入力されていないと進めない(アルファベットver)" do
      profile = build(:profile, family_name: "yamada")
      profile.valid?
      expect(profile.errors[:family_name]).to include("is invalid")
    end
    it "名字が全角で入力されていないと進めない(半角ｶﾀｶﾅver)" do
      profile = build(:profile,family_name: "ﾔﾏﾀﾞ")
      profile.valid?
      expect(profile.errors[:family_name]).to include("is invalid")
    end

    it "名前(かな)が全角入力されていないと進めない(アルファベットver)" do
      profile = build(:profile, first_name_kana: "hanako")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("is invalid")
    end
    it "名字(かな)が全角で入力されていないと進めない(半角ｶﾀｶﾅver)" do
      profile = build(:profile,first_name_kana: "ﾊﾅｺ")
      profile.valid?
      expect(profile.errors[:first_name_kana]).to include("is invalid")
    end

    it "名字(かな)が全角入力されていないと進めない(アルファベットver)" do
      profile = build(:profile, family_name_kana: "yamada")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("is invalid")
    end
    it "名字(かな)が全角で入力されていないと進めない(半角ｶﾀｶﾅver)" do
      profile = build(:profile,family_name_kana: "ﾔﾏﾀﾞ")
      profile.valid?
      expect(profile.errors[:family_name_kana]).to include("is invalid")
    end
  end
end