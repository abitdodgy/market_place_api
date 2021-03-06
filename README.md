This API is based on the API on Rails book. Several bugs present in the book are fixed along with a many code improvements. Some deviations:

1. I decided to use jbuilder instead of AMS.
2. I decided to use Pundit for authorization rather than vanila controller scoping (i.e: not current_user.foo).
3. I used MiniTest instead of Rspec. I used shoulda-matchers for the models.

The chapters are divided into branches. The master branch contains the most complete form of the app.

- [Setting Up](https://github.com/abitdodgy/market_place_api/tree/2-setting-api)
- [Presenting the Users](https://github.com/abitdodgy/market_place_api/tree/3-presenting-the-users)
- [Refactoring Tests](https://github.com/abitdodgy/market_place_api/tree/4-refactoring-tests)
- [Authenticating Uses](https://github.com/abitdodgy/market_place_api/tree/5-authenticating-users)
- [User Products](https://github.com/abitdodgy/market_place_api/tree/6-user-products)
- [Placeing Orders](https://github.com/abitdodgy/market_place_api/tree/8-placing-orders)

If you are looking for something faithful to the book, you might want to look elsewhere. The code base takes us all the way to the end, and is feature complete along with my own additional tests that were not present in the book.
