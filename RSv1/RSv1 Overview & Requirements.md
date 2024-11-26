# ReSeat Overview & Requirements

# Summary 

Ticket resale made simple. Users can log in and seamlessly search for venues. Below the search field, a “Hot Events Near You” section will showcase three featured events based on the
user’s location. Additional nearby events will be listed beneath, creating a scrollable page for effortless browsing. Each event listing will display the title, price, and date, with an
option to star events for quick access later. Selecting an event opens the Event Page, where users can view the event's title, date, and a list of ticket posts from other users. The
app’s bottom navigation bar includes four main pages: Listings Page for browsing events, Starred Page for saved events, Post an Ad Page for selling tickets, and Profile Page for
managing user information and activity. 

# Pages

1. #** Log In Page: (LoginView)

Header "Welcome" 
Subheadline - "Snag seats, swap stories, score the night!"

- Create Account CTA
- Text Field for Email and Password 
- Logo
- Background Animation 
- Continue as Guest CTA

Clicking on Continue as Guest CTA logs in as Guest. (View only, Not able to post)

Clicking on the Create Account CTA links to a separate “Create Account” Page. The credentials will be stored in Firebase so when user logs in again, the account is already active. 

2. #** Create Account Page: (CreateAccountView)

When user clicks on the “Create Account CTA” a new CreateAccountView is opened. This view will allow a user to create an account and the credentials will be stored in Firebase. The user
will then be redirected to the LoginView where they will be prompted to log in once again. 

- Create Account Title
- Text Field 1 : Name 
- Text Field 2 : Last Name
- Text Field 3 : Email
- Text Field 4 : Password   
- Next CTA

Clicking Next redirects user back to LoginView

3. #** Listing Page (ListingView)

- Headline: "Find Events Now"
- Search Field 
- Hot Events Near You (Small Section) -  This will show 3 random events in the Area.
- Event Type (Category) Selection Buttons - Concert, Sports, Comedy, Other. (Sort List to Display Ads posted in Specific Event Type)
- Scrollable List Of Nearby Events. When you Scroll, The search Field and Hot Event Section dissapears. 
- Tapping on Event opens Ad 
- Star Event 
- Bottom Navigation

4. #** Ad Page (AdView)

- Ad Title
- Inventory (How many tickets sellers put for sale)
- Price and Quantity (How many tickets buyer want to purchase)
- Seller Information (Information pulled from Create Account Data)
- Star Event
- Bottom Navigation

5. #** Starred Page (FavView)

- Headline: "Your Favourites"
- List of Starred Events from AdView or LisingView
- Bottom Navigation

6. #** Post Page (PostView) - Not Accessible In Guest Mode

- Headline: "Sell Now!"
- Event Type (Category) Dropdown: Concert, Sports, Comedy, Other. 
- Text Field 1 : Event Title 
- Text Field 2 : Price
- Text Field 3 : Quantity
- Bottom Navigation
- User's in Guest Mode will see a CTA saying "Login to Sell!" This CTA Redirects to LoginView

7. #** Profile Page (ProfileView)

- Headline "Welcome -Name-"
- Section: "Purchased Tickets"
- Shows purchased event tickets
- Section: "Sellers"
- Shows sold tickets, profit, costs, Others
- Log Out Button
- Bottom Navigation


# Future Scope 

- No Chat Feature
- Integrated Payment System
- Reminders of The Events.

# Conversation 

- Nov 26th:
Deepesh to Nikunj - Please check all changes and give me your thoughts about.
