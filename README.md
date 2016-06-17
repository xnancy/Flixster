# Project 2 - Flixster

Flixster is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 12 hours spent in total

## User Stories

The following **required** functionality is complete:

- [X] User can view a list of movies currently playing in theaters from The Movie Database.
- [X] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [X] User sees a loading state while waiting for the movies API.
- [X] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [ ] Movies are displayed using a CollectionView instead of a TableView.
- [X] User can search for a movie.
- [ ] All images fade in as they are loading.
- [X] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [X] Customize the navigation bar.
- [X] Customize the UI.

The following **additional** features are implemented:

- [X] List anything else that you can get done to improve the app functionality!
  
  ADDITIONAL FEATURES 
  --------------------------
  - Ability to sort movies by popularity, trending, kids, rated R 
  - Rating feature w/ stars using CocoaPods 
  - Details view w/ poster, expanded summary, rating, release date 
  - Save feature that saves and displays the most recent movie page 
  - Additional HUD displays when appropriate 
  - Custom indicator disclosure arrows 

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Implementing navigation controllers, interactions b/w navigation controllers, bars, and bar buttons 
2. Using segue transitions between views 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://imgur.com/ZNFQ1qi' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
The development process for this app went relatively smoothly. Working with navigation and segues was the most challenging aspect of the building the app, as in multiple cases, adding new nagivation elements such as a navigation controller resulted in layout changes that were problematic. Going forward, I hope to better understand the interaction between navigation controllers and segues (how to rewind, relationship between nagivation controllery and navigation bar, etc). 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [MBProgressHUD] (https://github.com/matej/MBProgressHUD) - an iOS activity indicator view
- [RateView] (https://github.com/taruntyagi697/RateView) - a subclass of UIView for ratings
- [IconFinder Disclosure Arrow] (https://www.iconfinder.com/icons/305797/arrow_circle_disclosure_forward_next_icon)

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
