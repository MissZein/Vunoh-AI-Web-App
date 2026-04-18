BEGIN TRANSACTION;
CREATE TABLE "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(150) NOT NULL UNIQUE);
CREATE TABLE "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);
INSERT INTO "auth_permission" VALUES(1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES(2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES(3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES(4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES(5,3,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES(6,3,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES(7,3,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES(8,3,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES(9,2,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES(10,2,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES(11,2,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES(12,2,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES(13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES(14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES(15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES(16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES(17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES(18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES(19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES(20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES(21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES(22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES(23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES(24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES(25,7,'add_task','Can add task');
INSERT INTO "auth_permission" VALUES(26,7,'change_task','Can change task');
INSERT INTO "auth_permission" VALUES(27,7,'delete_task','Can delete task');
INSERT INTO "auth_permission" VALUES(28,7,'view_task','Can view task');
CREATE TABLE "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "first_name" varchar(150) NOT NULL);
INSERT INTO "auth_user" VALUES(1,'pbkdf2_sha256$1200000$aBUAmSl7yIyPeEePzZT7Jy$vNnj9GOGC6r6VfH9cdzJLDeqmHwOy8pHVxeb8w3MJgs=','2026-04-18 11:04:30.826129',1,'zeinab','','zeinabumongina@gmail.com',1,1,'2026-04-18 10:58:58.751653','');
CREATE TABLE "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL CHECK ("action_flag" >= 0), "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "action_time" datetime NOT NULL);
CREATE TABLE "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);
INSERT INTO "django_content_type" VALUES(1,'admin','logentry');
INSERT INTO "django_content_type" VALUES(2,'auth','group');
INSERT INTO "django_content_type" VALUES(3,'auth','permission');
INSERT INTO "django_content_type" VALUES(4,'auth','user');
INSERT INTO "django_content_type" VALUES(5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES(6,'sessions','session');
INSERT INTO "django_content_type" VALUES(7,'tasks','task');
CREATE TABLE "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
INSERT INTO "django_migrations" VALUES(1,'contenttypes','0001_initial','2026-04-16 11:14:38.856629');
INSERT INTO "django_migrations" VALUES(2,'auth','0001_initial','2026-04-16 11:14:39.112952');
INSERT INTO "django_migrations" VALUES(3,'admin','0001_initial','2026-04-16 11:14:39.348962');
INSERT INTO "django_migrations" VALUES(4,'admin','0002_logentry_remove_auto_add','2026-04-16 11:14:39.526985');
INSERT INTO "django_migrations" VALUES(5,'admin','0003_logentry_add_action_flag_choices','2026-04-16 11:14:39.703744');
INSERT INTO "django_migrations" VALUES(6,'contenttypes','0002_remove_content_type_name','2026-04-16 11:14:39.865097');
INSERT INTO "django_migrations" VALUES(7,'auth','0002_alter_permission_name_max_length','2026-04-16 11:14:40.017733');
INSERT INTO "django_migrations" VALUES(8,'auth','0003_alter_user_email_max_length','2026-04-16 11:14:40.179116');
INSERT INTO "django_migrations" VALUES(9,'auth','0004_alter_user_username_opts','2026-04-16 11:14:40.293826');
INSERT INTO "django_migrations" VALUES(10,'auth','0005_alter_user_last_login_null','2026-04-16 11:14:40.455494');
INSERT INTO "django_migrations" VALUES(11,'auth','0006_require_contenttypes_0002','2026-04-16 11:14:40.558650');
INSERT INTO "django_migrations" VALUES(12,'auth','0007_alter_validators_add_error_messages','2026-04-16 11:14:40.656684');
INSERT INTO "django_migrations" VALUES(13,'auth','0008_alter_user_username_max_length','2026-04-16 11:14:40.791224');
INSERT INTO "django_migrations" VALUES(14,'auth','0009_alter_user_last_name_max_length','2026-04-16 11:14:40.972712');
INSERT INTO "django_migrations" VALUES(15,'auth','0010_alter_group_name_max_length','2026-04-16 11:14:41.154531');
INSERT INTO "django_migrations" VALUES(16,'auth','0011_update_proxy_permissions','2026-04-16 11:14:41.303984');
INSERT INTO "django_migrations" VALUES(17,'auth','0012_alter_user_first_name_max_length','2026-04-16 11:14:41.477939');
INSERT INTO "django_migrations" VALUES(18,'sessions','0001_initial','2026-04-16 11:14:41.653033');
INSERT INTO "django_migrations" VALUES(19,'tasks','0001_initial','2026-04-16 11:14:41.732993');
CREATE TABLE "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
INSERT INTO "django_session" VALUES('0e7stpgigfvqq5iuofp86rd3w0oggrq8','.eJxVjEEOwiAQAP-yZ0NYShfo0btvIAtspWrapLQn499Nkx70OjOZN0Tetxr3JmucCgyAcPllifNT5kOUB8_3ReVl3tYpqSNRp23qthR5Xc_2b1C5VRhg7Nk5q7kng15TCIlMzuS1IR65dOS90x1yEUQ02iI5zuhEUAJhsvD5Arl0NtM:1wE3TS:nwFWbGoDbHFakpsbIFDduIavQS8IxHY1xXMoDEnK010','2026-05-02 11:04:30.917691');
CREATE TABLE "tasks_task" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "task_code" varchar(12) NOT NULL UNIQUE, "original_request" text NOT NULL, "intent" varchar(50) NOT NULL, "entities" text NOT NULL CHECK ((JSON_VALID("entities") OR "entities" IS NULL)), "risk_score" integer NOT NULL, "assigned_team" varchar(50) NOT NULL, "process_steps" text NOT NULL CHECK ((JSON_VALID("process_steps") OR "process_steps" IS NULL)), "whatsapp_message" text NOT NULL, "email_message" text NOT NULL, "sms_message" text NOT NULL, "status" varchar(20) NOT NULL, "created_at" datetime NOT NULL);
INSERT INTO "tasks_task" VALUES(1,'ED1A2424','I want to verify a title deed for a plot in Syokimau. It''s urgent.','verify_document','{"document_type": "title deed", "location": "Syokimau", "urgency": "urgent"}',85,'Legal','["Contact client to gather required documents (copy of title deed, KRA PIN, ID).", "Initiate official search at the Ministry of Lands in Nairobi to confirm ownership and authenticity.", "If required, engage a licensed surveyor to verify plot boundaries and beacon placement.", "Compile and provide a detailed verification report to the client with findings and recommendations."]','Got it! We''re urgently verifying your Syokimau title deed. Our Legal team is on it, we''ll keep you updated!','Subject: Vunoh Global: Urgent Title Deed Verification Request - Syokimau

Dear [Client Name],

This email confirms receipt of your urgent request to verify a title deed for a plot located in Syokimau. Our Legal team has been assigned and will immediately commence the verification process with the relevant authorities. We will provide you with a comprehensive report upon completion.

Kind regards,
The Vunoh Global Team','Vunoh Global: Urgent title deed verification for Syokimau plot initiated by Legal team. Updates via email.','Completed','2026-04-17 05:51:59.570126');
INSERT INTO "tasks_task" VALUES(2,'DF0F720C','I want to verify a title deed for a plot in Syokimau. It''s urgent.','Verify Title Deed','{"task": "verify title deed", "location": "Syokimau", "urgency": "urgent", "document_type": "title deed"}',85,'Legal & Property Team','["Collect detailed title deed information from client.", "Engage local legal counsel for official land registry search.", "Conduct title deed search at the Ministry of Lands and Housing.", "Obtain and verify the official search certificate.", "Prepare a comprehensive verification report for the client."]','Hi Vunoh Global, I''m following up on my urgent request to verify a title deed for a plot in Syokimau. Please let me know what details you need from me to proceed.','{''subject'': ''Urgent Title Deed Verification Request - Syokimau Plot'', ''body'': ''Dear Vunoh Global Team,\n\nI am writing to request urgent assistance with verifying a title deed for a plot located in Syokimau. Please advise on the necessary information and next steps to expedite this verification process.\n\nThank you.''}','Vunoh Global: Acknowledging your urgent title deed verification request for a Syokimau plot. Our team will contact you shortly for details. Reply to this SMS for immediate assistance.','In Progress','2026-04-18 04:42:01.083253');
INSERT INTO "tasks_task" VALUES(3,'E8961D64','Can someone clean my apartment in Westlands on Friday?','Schedule Cleaning Service','{"service_type": "apartment cleaning", "location": "Westlands", "date": "Friday"}',15,'Home Services Team','["Acknowledge cleaning request for Westlands on Friday.", "Confirm specific time preference with the user.", "Identify available and vetted cleaning professionals in Westlands.", "Provide user with cleaner options and estimated costs.", "Confirm booking and share cleaner''s details with the user."]','Yes','No','No','Completed','2026-04-18 04:51:11.572526');
INSERT INTO "tasks_task" VALUES(4,'0D199AB6','I need to send KES 15,000 to my mother in Kisumu urgently','Money Transfer','{"amount": "KES 15,000", "recipient": "mother", "location": "Kisumu", "urgency": "urgent"}',50,'Financial Services','["Confirm recipient details (full name, phone number, M-Pesa/bank details).", "Confirm sender''s preferred payment method for the KES 15,000.", "Process the urgent money transfer to the recipient.", "Notify sender and recipient upon successful transfer.", "Provide transaction confirmation/receipt."]','Task update regarding your Money Transfer request.','Task update regarding your Money Transfer request.','Task update regarding your Money Transfer request.','Pending','2026-04-18 05:10:28.354591');
INSERT INTO "tasks_task" VALUES(5,'C3F0C18A','My tenant in Roysambu says the water pump is broken and they have no water. Can you find a plumber to fix it today? The budget is KES 5,000.','Property Maintenance Request','{"property_location": "Roysambu", "issue": "broken water pump", "urgency": "today", "budget": "KES 5,000", "contact_person": "tenant"}',45,'Property Management & Maintenance','["Confirm details and availability with the tenant in Roysambu.", "Source and vet at least 2 qualified plumbers in the Roysambu area.", "Obtain quotes from plumbers, ensuring they are within the KES 5,000 budget.", "Present plumber options and quotes to the client for approval.", "Schedule the plumber to fix the water pump today, coordinating access with the tenant.", "Oversee the repair to ensure quality and completion.", "Process payment to the plumber upon successful completion and client''s satisfaction.", "Provide a detailed report and invoice to the client."]','We''ve received your request to fix the water pump in Roysambu. Our team will start sourcing plumbers and will share options with you shortly. We aim to get this resolved today!','Subject: Action Required: Water Pump Repair in Roysambu

Dear [Client Name],

This email confirms receipt of your request to address the broken water pump at your property in Roysambu. Your tenant has informed us of the issue, and we understand the urgency.

Our Property Management & Maintenance team has commenced the process of sourcing qualified plumbers in the Roysambu area. We will obtain competitive quotes, keeping your budget of KES 5,000 in mind, and present them to you for approval.

Our goal is to have the repair completed today. We will keep you updated on our progress and will coordinate directly with your tenant for access.

Should you have any further details or preferences, please reply to this email or contact us directly.

Sincerely,
The Vunoh Global Team','Vunoh Global: We''re on it! Plumbers being sourced for your Roysambu water pump. Will share options & aim to fix today. Updates coming soon.','In Progress','2026-04-18 05:17:30.242015');
INSERT INTO "tasks_task" VALUES(6,'242DC585','I need to hire a reputable lawyer to help with a land transfer in Kitengela. I have the title deed and I need to make sure the search is done correctly at the land registry.','Legal and Property Assistance','{"service_requested": "Hire a reputable lawyer", "task": "Land transfer", "location": "Kitengela", "document_provided": "Title deed", "specific_action": "Land search at the land registry"}',75,'Legal & Property Team','["Vunoh Global will connect with the client to gather full details of the land transfer (e.g., specific parcel number, seller/buyer details if available).", "Vunoh Global will source and vet reputable property lawyers specializing in land transfers in Kitengela.", "We will present a selection of lawyer profiles and their estimated quotes/scope of work to the client for approval.", "Upon client selection, Vunoh Global will facilitate the engagement with the chosen lawyer.", "The assigned lawyer will conduct a thorough land search at the Kitengela Land Registry using the provided title deed details.", "The lawyer will oversee all aspects of the land transfer process, ensuring legal compliance and secure transfer.", "Vunoh Global will provide regular updates to the client on the progress of the land transfer."]','Task update regarding your Legal and Property Assistance request.','Task update regarding your Legal and Property Assistance request.','Task update regarding your Legal and Property Assistance request.','Pending','2026-04-18 05:21:47.053875');
INSERT INTO "tasks_task" VALUES(7,'3E879070','I want to pay school fees for my niece at a high school in Eldoret. The amount is KES 45,000. Please send me the confirmation once the bank transfer is complete.','Pay School Fees','{"recipient_relationship": "niece", "payment_type": "school fees", "location": "Eldoret", "amount": "KES 45,000", "confirmation_requested": true}',45,'Financial Services','["Contact user to obtain full school name, bank account details, and student ID for fee payment.", "Verify payment details and amount with the user.", "Initiate bank transfer for KES 45,000 to the specified school account.", "Obtain payment confirmation/receipt from the school or bank.", "Send payment confirmation and receipt to the user."]','Task update regarding your Pay School Fees request.','Task update regarding your Pay School Fees request.','Task update regarding your Pay School Fees request.','Pending','2026-04-18 05:23:26.859248');
INSERT INTO "tasks_task" VALUES(8,'8566915B','Clean my house in Ruaraka','House Cleaning Service','{"service_type": "house cleaning", "location": "Ruaraka"}',15,'Home Services','["Contact user to confirm house size, preferred date/time, and specific cleaning requirements.", "Source and vet reliable cleaning service providers in the Ruaraka area.", "Obtain quotes from vetted providers and present options to the user.", "Once approved, schedule the cleaning service.", "Oversee or verify completion of the cleaning service.", "Confirm satisfaction with the user."]','Hi there! We''ve received your request to clean your house in Ruaraka. To help us find the best service, could you please tell us the size of your house (e.g., number of bedrooms/bathrooms), your preferred date/time, and any specific cleaning needs? We''ll get started on sourcing quotes for you!','Subject: Your House Cleaning Request for Ruaraka - Vunoh Global

Dear [Client Name],

Thank you for reaching out to Vunoh Global. We''ve received your request for house cleaning services in Ruaraka.

To ensure we provide you with the best options and accurate quotes, could you please provide us with the following details:

1.  **Size of your house:** (e.g., number of bedrooms, bathrooms, approximate square footage)
2.  **Preferred date(s) and time(s) for the cleaning.**
3.  **Any specific cleaning requirements:** (e.g., deep clean, standard clean, specific areas to focus on, laundry, window cleaning, etc.)

Once we have this information, our Home Services team will immediately begin sourcing and vetting reliable cleaning providers in Ruaraka. We''ll then present you with options and quotes for your approval.

We aim to make this process as seamless as possible for you.

Best regards,
The Vunoh Global Team','Vunoh Global: We received your request for house cleaning in Ruaraka. Reply to our WhatsApp/Email for details on house size, date/time, and specific needs to get started. Thank you!','Pending','2026-04-18 05:37:59.859140');
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_group_id_97559544" ON "auth_user_groups" ("group_id");
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" ("expire_date");
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('django_migrations',19);
INSERT INTO "sqlite_sequence" VALUES('django_admin_log',0);
INSERT INTO "sqlite_sequence" VALUES('django_content_type',7);
INSERT INTO "sqlite_sequence" VALUES('auth_permission',28);
INSERT INTO "sqlite_sequence" VALUES('auth_group',0);
INSERT INTO "sqlite_sequence" VALUES('auth_user',1);
INSERT INTO "sqlite_sequence" VALUES('tasks_task',8);
COMMIT;
