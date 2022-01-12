import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById("navigation_ending_address");
  if (addressInput) {
    console.log ("coucou")
    places({ container: addressInput });
  }
};

export { initAutocomplete };
