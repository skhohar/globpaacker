import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/light-v10',
    center: [-122.662323, 45.523751], // starting position
    zoom: 12
  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([marker.lng, marker.lat])
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const addDirectionToMap = (map) => {
  var directions = new MapboxDirections({
    accessToken: mapboxgl.accessToken
  });
  map.addControl(directions, 'top-left');
}

const getMyPosition = (map) => {
  function success(pos) {
    const crd = pos.coords;
    const myCoordArray = [];

    console.log('Votre position actuelle est :');
    console.log(crd)
    console.log(`Latitude : ${crd.latitude}`);
    console.log(`Longitude : ${crd.longitude}`);
    console.log(`La précision est de ${crd.accuracy} mètres.`);
    return myCoordArray.push(crd.longitude, crd.latitude)
  }

  function error(err) {
    console.warn(`ERREUR (${err.code}): ${err.message}`);
  }
  navigator.geolocation.getCurrentPosition(success, error);
}


const initMapbox = () => {
  const mapElement = document.getElementById('map');


  if (mapElement) { // only build a map if there's a div#map to inject into
    console.log("geoloc")
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    navigator.geolocation.getCurrentPosition(position => {
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/light-v10',
        center: [position.coords.longitude, position.coords.latitude],
        zoom: 14
      });
      // const markers = JSON.parse(mapElement.dataset.markers);
      // markers.forEach((marker) => {
      // new mapboxgl.Marker()
      //   .setLngLat([position.coords.longitude, position.coords.latitude])
      //   .addTo(map);
      // });
      const start = [position.coords.longitude, position.coords.latitude];
      // create a function to make a directions request
      async function getRoute(end) {
        // make a directions request using cycling profile
        // an arbitrary start will always be the same
        // only the end or destination will change
        const query = await fetch(
          `https://api.mapbox.com/directions/v5/mapbox/walking/${start[0]},${start[1]};${end[0]},${end[1]}?steps=true&geometries=geojson&access_token=${mapboxgl.accessToken}`,
          { method: 'GET' }
        );
        const json = await query.json();
        const data = json.routes[0];
        const route = data.geometry.coordinates;
        const geojson = {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'LineString',
            coordinates: route
          }
        };
        // if the route already exists on the map, we'll reset it using setData
        if (map.getSource('route')) {
          map.getSource('route').setData(geojson);
        }
        // otherwise, we'll make a new request
        else {
          map.addLayer({
            id: 'route',
            type: 'line',
            source: {
              type: 'geojson',
              data: geojson
            },
            layout: {
              'line-join': 'round',
              'line-cap': 'round'
            },
            paint: {
              'line-color': '#3887be',
              'line-width': 5,
              'line-opacity': 0.75
            }
          });
        }
        // add turn instructions here at the end
      }

      map.on('load', () => {
        // make an initial directions request that
        // starts and ends at the same location
        getRoute(start);

        // Add starting point to the map
        map.addLayer({
          id: 'point',
          type: 'circle',
          source: {
            type: 'geojson',
            data: {
              type: 'FeatureCollection',
              features: [
                {
                  type: 'Feature',
                  properties: {},
                  geometry: {
                    type: 'Point',
                    coordinates: start
                  }
                }
              ]
            }
          },
          paint: {
            'circle-radius': 10,
            'circle-color': '#3887be'
          }
        });
        // this is where the code from the next step will go
        //On récupère la destination rentré par l'utilisateur -> navigation -> new
        const finalDestination = document.querySelector("#finalDestination");
        const destinationForm = document.querySelector("#new_navigation");
        map.on('click', (event) => {
          event.preventDefault();
          // const coords = Object.keys(event.lngLat).map((key) => event.lngLat[key]);
          // console.log(coords)
          const coords = ["5.394641", "43.269605"]
          const end = {
            type: 'FeatureCollection',
            features: [
              {
                type: 'Feature',
                properties: {},
                geometry: {
                  type: 'Point',
                  coordinates: coords
                }
              }
            ]
          };
          if (map.getLayer('end')) {
            map.getSource('end').setData(end);
          } else {
            map.addLayer({
              id: 'end',
              type: 'circle',
              source: {
                type: 'geojson',
                data: {
                  type: 'FeatureCollection',
                  features: [
                    {
                      type: 'Feature',
                      properties: {},
                      geometry: {
                        type: 'Point',
                        coordinates: coords
                      }
                    }
                  ]
                }
              },
              paint: {
                'circle-radius': 10,
                'circle-color': '#f30'
              }
            });
          }
          getRoute(coords);
        });

      });

    });



    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);

    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
    // addDirectionToMap(map);
    // printMyLocation(map);



    // map.addControl(
    //   new mapboxgl.GeolocateControl({
    //     positionOptions: {
    //       enableHighAccuracy: true
    //     },
    //     // When active the map will receive updates to the device's location as it changes.
    //     trackUserLocation: true,
    //     // Draw an arrow next to the location dot to indicate which direction the device is heading.
    //     showUserHeading: true
    //   })
    // );

    // const instructions = document.getElementById('instructions');
    // const steps = data.legs[0].steps;

    // let tripInstructions = '';
    // for (const step of steps) {
    //   tripInstructions += `<li>${step.maneuver.instruction}</li>`;
    // }
    // instructions.innerHTML = `<p><strong>Trip duration: ${Math.floor(
    //   data.duration / 60
    // )} min :walking: </strong></p><ol>${tripInstructions}</ol>`;
  }

};

export { initMapbox };
