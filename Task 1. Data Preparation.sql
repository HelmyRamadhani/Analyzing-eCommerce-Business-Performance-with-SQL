

/*TASK 1

Subtask 1:
Membuat database baru beserta tabel-tabelnya untuk data yang sudah disiapkan
*/

create database ecommerce

/*
Membuat tabel untuk sembilan data csv 

Terdapat 9 dataset berekstensi csv, maka kita membuat 9 tabel pula untuk menyimpan dataset tersebut, 
dan sesuaikan tipe dari setiap kolom berdasarkan pada dataset di file csv
*/

create table customers (
	customer_id varchar(250),
	customer_unique_id varchar(250),
	customer_zip_code_prefix int,
	customer_city varchar(250),
	customer_state varchar(250)
);

create table geolocation (
	geo_zip_code_prefix varchar(250),
	geo_lat varchar(250),
	geo_lng varchar(250),
	geo_city varchar(250),
	geo_state varchar(250)
);

create table order_item (
	order_id varchar(250),
	order_item_id int,
	product_id varchar(250),
	seller_id varchar(250),
	shipping_limit_date timestamp,
	price float,
	freight_value float
);

create table payments (
	order_id varchar(250),
	payment_sequential int,
	payment_type varchar(250),
	payment_installment int,
	payment_value float
);


create table reviews (
	review_id varchar(250),
	order_id varchar(250),
	review_score int, 
	review_comment_title varchar(250),
	review_comment_message text,
	review_creation_date timestamp,
	review_answer timestamp
);

create table orders (
	order_id varchar(250),
	customers_id varchar(250),
	order_status varchar(250),
	order_purchase_timestamp timestamp,
	order_approved_at timestamp,
	order_delivered_carrier_date timestamp,
	order_delivered_customer_date timestamp,
	order_estimated_delivered_date timestamp
);

create table products (
	product_id varchar(250),
	product_category_name varchar(250),
	product_name_length int,
	product_description_length int,
	product_photos_qty int,
	product_weight_g int,
	product_length_cm int,
	product_height_cm int,
	product_width_cm int
);

create table sellers (
	seller_id varchar(250),
	seller_zip_code int,
	seller_city varchar(250),
	seller_state varchar(250)
);

/*
Subtask 2: 
Importing data csv ke dalam database

Dalam mengimpor data csv ke database, tipe data dari kolom di database harus sama dengan tipe dataset di file csv. 
Jika terdapat perbedaan maka proses impor akan error. Selain itu  path folder penyimpanan  dataset harus lengkap 
sampai nama_file.csv.
*/

copy customers(
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
)
from 'C:\Users\Helmy\Belajar Python With Rakamin\Mini ProjectSQL\Dataset\customers_dataset.csv'
delimiter ','
csv header;

copy geolocation(
	geo_zip_code_prefix,
	geo_lat,
	geo_lng,
	geo_city,
	geo_state
)
from 'C:\Users\Helmy\Belajar Python With Rakamin\Mini ProjectSQL\Dataset\geolocation_dataset.csv'
delimiter ','
csv header;

/*
Subtask 3:
Membuat entity relationship antar tabel, berdasarkan skema di bawah ini. 
Kemudian export Entity Relationship Diagram (ERD)  dalam bentuk gambar.

Berdasarkan gambar skema yang diberikan, dapat dilihat bahwa diantara panah 
yang menghubungkan setiap dataset terdapat nama kolom ditengahnya. Hal tersebut 
menunjukkan bahwa, kolom tersebut menjadi kolom kunci yang menghubungkan dataset dengan dataset lainnya.

Sebagai contoh, dataset order_item (warna orange) berhubungan  dengan dataset 
product (warna kuning) dengan kolom kunci nya adalah kolom product_id. 

Jika kita telaah lagi, dalam dataset order_item maupun product terdapat kolom product_id. 
Akan tetapi, dalam dataset product semua value dari kolom product_id unik (tunggal), s
edangkan dalam dataset order_item value dari kolom product_id ada yang tidak unik (ada value yang sama). 
Oleh karena itu, kolom product_id merupakan primary key dari dataset product dan merupakan foreign key 
untuk dataset order_item. Sehingga query yang tepat adalah
*/

alter table products add constraint pk_products primary key (product_id);
alter table order_items add foreign key (product_id) references products;

/*
Untuk hubungan antar dataset yang lainnya dapat menggunakan cara yang  
sama seperti contoh sebelumnya dalam menentukan primary key dan foreign key, 
sehingga diperoleh query yang tepat sbb:
*/

/*Primary key untuk tabel lainnya*/

alter table customers add constraint pk_cust primary key (customer_id);
alter table geolocation add constraint pk_geo primary key (geo_zip_code_prefix);
alter table orders add constraint pk_orders primary key (order_id);
alter table sellers add constraint pk_seller primary key (seller_id);


/*Foreign key untuk hubungan antar tabel lainnya*/

alter table customers add foreign key (customer_zip_code_prefix) references geolocation;
alter table orders add foreign key (customer_id) references customers;
alter table order_items add foreign key (order_id) references orders;
alter table order_items add foreign key (seller_id) references sellers;
alter table sellers add foreign key (seller_zip_code_prefix) references geolocation;
alter table payments add foreign key (order_id) references orders;
alter table order_items add foreign key (product_id) references products;
alter table reviews add foreign key (order_id) references orders;

