## Globp@cker: Final team project for Le Wagon web dev bootcamp

### About the project:
<strong>Group composition</strong>: 3 fullstack developers participating in Le Wagon.<br>
<strong>Lead dev for this project</strong>: @rikufonseca.<br>
<strong>Duration</strong>: 9 days.

### Technical specifications:

This app is built using [Le Wagon minimal + devise rails template](https://github.com/lewagon/rails-templates).

It is mainly based on the [Mapbox navigation API](https://docs.mapbox.com/api/overview/).

The app is designed to be seen from an iphone XR.


### About the product:

This app is...<br>
__for__ backpackers or lightweight travellers - 20-30 something with limited budget, the ability to move easily, and looking for original/alternative experiences,<br>
__who need to__ maximise their traveling enjoyment, <br>
__which means they want to__ make sure to not miss an opportunity to experience one more thing, while being on time to take the transportation for their next destination.<br>
__Globp@cker answers by__ offering a walking navigation tool, which allows to browse authentic things to do/see/smell/hear while respecting a specific time deadline and staying close to the user's itinerary.

#### An illustration:
Marie is parisian, she booked a 2 day stay on the Frioul island, off the coast of Marseilles, France. Her train arrives at the central train station at 10am, but her boat is booked for 1pm on the Vieux Port. When she goes out of the station, she sees that walking straight from the station to the port would only take 20 minutes. Instead of spending time sitting in a coffee shop, she would like to use this opportunity to get to know Marseilles a little bit. She needs activities that will respect the time available before embarking on the boat, as well as not taking her too far from her endpoint (risk to get lost), so she can feel safe and have a free mind.

She opens Globp@cker, and sees where she is. She enters where she needs to go and when she needs to reach this place. She can specify the weather, so that suggested activities mare better suited.

The app provides her a map with the most direct itinerary, as well as the time she has left to do things (which is an equivalent to the time she will have left once she reach her destination).
On the map, she can see all the activities available near her itinerary. When clicking on one, she gets a preview (suggested time to spend at it, picture, etc...). She can click on the preview, get more info, and add it to her itinerary. 

If she does so, she will see that two things have been updated:
1/ the itinerary now goes through the place to visit,
2/ the time left, taking into account the passing of time, the new walking duration, and the time suggested to spend doing the activity.
She can add as many activities as she wants, until the app shows a remaining time close to 0 minutes.

She can then walk to the first activity. When she reaches the place where it happens, she can read more specific info. When she is done, she can signal it to the app, so that the time remaining can be updated (in case she spent more or less time than suggested doing the activity).
At any moment, she can select and add a new activity to her itinerary.

At the end, she arrives at the port in time, with many more memories in her head than what she would have dared experimenting without Globp@cker.


### Further developments:

If we had more time, we would have wanted to:

* Set an alert when there is no time left to wander, so that the user doesn't have to check on their screen,
* Only allow the possibility to add an activity when there is enough time left,
* Offer possibility for user to remove an activity from the itinerary,
* Be more selective with the activities display on the map: only show those who are actually doable within the available time,
* Find a way to add activities to the itinerary so that they are in the most logical order (right now it add them to the itinerary in the order the user selected them),
* Offer possibility for users to add activities to the app,
* Offer possibility for users to rate and comment an activity, and make it a favorite in order to find it again later,
* Offer the possibility to consult archives of past itineraries,
* Seed more activities/places,
* Maybe: add the possibility to have a navigation other than walking.
* ...
