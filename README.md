# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| info                   | text       | null: false                    |
| category_id            | integer    | null: false # ActiveHash       |
| sales_status_id        | integer    | null: false # ActiveHash       |
| shipping_fee_status_id | integer    | null: false # ActiveHash       |
| prefecture_id          | integer    | null: false # ActiveHash       |
| scheduled_delivery_id  | integer    | null: false # ActiveHash       |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| postal_code    | string     | null: false                    |
| prefecture_id  | integer    | null: false # ActiveHash       |
| city           | string     | null: false                    |
| street_address | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false                    |
| order          | references | null: false, foreign_key: true |

### Association

- belongs_to :order

## 補足：ActiveHashを使用しているモデル

以下の項目は ActiveHash を用いて管理しています（データベースには保存されません）：

- Category（商品カテゴリ）
- SalesStatus（商品の状態）
- ShippingFeeStatus（配送料の負担）
- Prefecture（発送元の地域）
- ScheduledDelivery（発送までの日数）

これらのデータは `app/models` ディレクトリ内の各 `.rb` ファイルで定義されています。