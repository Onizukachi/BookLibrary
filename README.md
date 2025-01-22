Fullstack Shop: Ruby on Rails 7, Hotwire, Tailwind, Stripe, PostgreSQL

![image](https://github.com/user-attachments/assets/04c69604-64ca-4478-bd3f-99fa3859c6be)
![image](https://github.com/user-attachments/assets/1b53f5a5-9258-41f4-b3fb-2c5a4fbf7d1d)


## Getting started

To get started with the app, first clone the repo and `cd` into the directory:

```
$ git clone https://github.com/Onizukachi/Clothing-Store.git
$ cd Clothing-Store
```

Then install the needed gems (while skipping any gems needed only in production):

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Add your env variables to the `config/credentials.yml.enc` file. You can do this by running `bin/rails credentials:edit`


Finally, run the test suite to verify that everything is working correctly:

```
$ rspec
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ bin/dev
```
