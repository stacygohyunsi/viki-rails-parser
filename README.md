# Viki movies parser

A simple Rails shows parser that checks if the shows in the homepage are showing repeated content to the user. 

# Approach
Although I only just started using Rails, I wanted to challenge myself with this assignment. 
1. Determine the pattern in the CSS of the different sections in the homepage
2. Use Nokogiri Parser to parse the content and get the unique links
3. Use a hash table to determine if there is any repeats in shows

# Why best way to do it?
1. Because I can trigger an API call anytime I want
2. I can set up a cron job to check for duplicates on a periodic basis

# Usage

1. Clone the repo
2. `bundle install`
2. Run "rails server"
3. Go to localhost:3000
4. It auto refreshes the page every 10 minutes, making it an awesome dashboard for the team populating the content on the homepage.

Alternatively, to access an api endpoint you can go to localhost:3000/api

# Parsed contents

Unable to parse sections **Top picks for you**, **recommended clips** and **newly added episodes** because I am unable to get its elements from the page source.

- [x] Carousel items
- [x] Trending in Singapore
- [ ] Top picks for you
- [ ] Recommended clips for you
- [x] Viki Picks
- [x] Fan collections
- [ ] Newly added episodes
- [x] Currently on air
- [x] Coming soon

# Assumptions
- Ruby 2.2.2 or newer is installed
- Gem is also installed 