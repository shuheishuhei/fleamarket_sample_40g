
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|mail|string|null: false, unique:true|
### Association
- has_many :items
- has_one :profile
- has_one: address
- has_one: credit

## profilesテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|birth_year|date|null: false|
|birth_month|date|null: false|
|birth_day|date|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|distination_first_name|string|null: false|
|distination_family_name|string|null: false|
|distination_first_name_kana|string|null: false|
|distination_family_name_kana|string|null: false|
|post_code|integer|null: false|
|prefucture_code|integer|null: false|
|city|string|null: false|
|house_number|integer|null: false|
|building_name|string||
|phone_number|integer|unique: true|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|credit_number|integer|null: false|unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introducion|text|null: false|
|price|integer|null: false|
|category_id|references|null: false, foreign_key: true|
|item_images_id|references|null: false, foreign_ker: true|
|sizing_id|references|foreign_key: true|
|item_conditions_id|references|foreign_key: true|
|postage_pay_id|references|null: false, foreign_key: true|
|preparation_day_id|references|null: false,foreign_key: true|
|prefucture_code|integer||
|buyer_id|references|null: false, foreign_key: true|
|seller_id|references|null: false, foreing_key: true|
### Association
- has_many: images
- belongs_to: user
- belongs_to: category
- belongs_to: brand
- belongs_to_active_hash: size
- belongs_to_active_hash: item_condition
- belongs_to_active_hash: preparation_day
- belongs_to_active_hash: postage_payer

## item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key|
### Association
- has_many: items

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many: items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Assiciation
- has_many: items

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|size|string|null: false|
### Assiciation
- has_many: items

## preparation_daysテーブル
|Column|Type|Options|
|------|----|-------|
|preparation_day|string|null: false|
### Association
- has_many :items

## item_conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|item_condition|string|null: false|
### Association
- has_many :items

## postage_payersテーブル
|Column|Type|Options|
|------|----|-------|
|postage_payer|string|null: false|
### Association
- has_many :items