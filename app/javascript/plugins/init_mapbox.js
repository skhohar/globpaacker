import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';


// const addDirectionToMap = (map) => {
//   var directions = new MapboxDirections({
//     accessToken: mapboxgl.accessToken
//   });
//   map.addControl(directions, 'top-left');
// }

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker[0], marker[1]]));
  map.fitBounds(bounds, { padding: 50, maxZoom: 15, duration: 0 });
};

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

        async function getAndDisplayRoute(start, end) {
          // makes a directions request using walking profile
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
          const navMarkers = [navStartingCoords, navEndingCoords]

      // create a function to make a directions request

      map.on('load', () => {


        if (navEndingCoords[1] && navEndingCoords[0]) {
          // make an initial directions request that
          // starts and ends at the same location

          const places = JSON.parse(mapElement.dataset.places);
            places.forEach((place) => {
              const popup = new mapboxgl.Popup().setHTML(place.info_window);
              new mapboxgl.Marker()
                .setLngLat([
                  place.lng,
                  place.lat
                ])
                .setPopup(popup)
                .addTo(map);
            });

          getAndDisplayRoute(navStartingCoords, navEndingCoords);
          fitMapToMarkers(map, navMarkers);
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
                      coordinates: navStartingCoords // this needs to be an array of coordinates (beware, not an object)
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
  }
};

export { initMapbox };
