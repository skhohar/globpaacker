import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById("navigation_ending_address");
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
