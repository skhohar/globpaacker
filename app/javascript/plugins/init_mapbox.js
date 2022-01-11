import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';


// const addDirectionToMap = (map) => {
//   var directions = new MapboxDirections({
//     accessToken: mapboxgl.accessToken
//   });
//   map.addControl(directions, 'top-left');
// }

const initMapbox = () => {
  const mapElement = document.getElementById('map');


  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    navigator.geolocation.getCurrentPosition(position => {
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/light-v10',
        center: [position.coords.longitude, position.coords.latitude],
        zoom: 14
      });
      // markers.forEach((marker) => {
        // new mapboxgl.Marker()
        //   .setLngLat([position.coords.longitude, position.coords.latitude])
        //   .addTo(map);
        // });
        async function getAndDisplayRoute(start, end) {
          // make a directions request using walking profile
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

          const navStartingCoords = [position.coords.longitude, position.coords.latitude];
          const navEndingCoords = [
            JSON.parse(mapElement.dataset.nav)[1]?.lng,
            JSON.parse(mapElement.dataset.nav)[1]?.lat
          ]
      // create a function to make a directions request

      map.on('load', () => {

        if (navEndingCoords[1] && navEndingCoords[0]) {
          // make an initial directions request that
          // starts and ends at the same location
          getAndDisplayRoute(navStartingCoords, navEndingCoords);

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
                      coordinates: navStartingCoords
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
          // On récupère la destination rentré par l'utilisateur -> navigation -> new

            // const coords = navEndingCoords
            const end = {
              type: 'FeatureCollection',
              features: [
                {
                  type: 'Feature',
                  properties: {},
                  geometry: {
                    type: 'Point',
                    coordinates: navEndingCoords
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
                          coordinates: navEndingCoords
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
            getAndDisplayRoute(navStartingCoords, navEndingCoords);
        } else {
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
                        coordinates: navStartingCoords
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
        }
      });

    });


    // addDirectionToMap(map);



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
