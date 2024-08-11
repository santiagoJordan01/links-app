
// Seleccionar input al dar click en icono de mouse
document.addEventListener("DOMContentLoaded", function() {
    const searchIcon = document.querySelector("#icon-search");
    const searchInput = document.querySelector("#buscar-productos");

    searchIcon.addEventListener("click", function() {
        searchInput.focus();
    });
});

// desplegar menú al dar click en el botón de menú


document.querySelector(".menu-btn").addEventListener("click", () => {
    document.querySelector(".nav-menu-primary").classList.toggle("show");
  });
  

// desplegar input de busqueda al hacer click en icono de lupa




// Borde negro en su contenedor tras oprimir el input de buscar productos
const inputBuscar = document.getElementById('buscar-productos');
const navMenuRight = document.querySelector('.nav-menu-right');

inputBuscar.addEventListener('click', function() {
    navMenuRight.classList.add('borde-negro');
});

// Remover la clase cuando el input pierda el foco
inputBuscar.addEventListener('blur', function() {
    navMenuRight.classList.remove('borde-negro');
});




// header carrusel
document.addEventListener('DOMContentLoaded', () => {
    const track = document.getElementById('carrusel-track');
    const slides = Array.from(track.children);
    const nextButton = document.getElementById('button-next');
    const prevButton = document.getElementById('button-prev');
    const indicators = document.getElementById('carrusel-indicators').children;

    let currentSlide = 0;

    const updateIndicators = () => {
        Array.from(indicators).forEach((indicator, index) => {
            indicator.classList.toggle('active', index === currentSlide);
        });
    };

    const moveToSlide = (targetIndex) => {
        track.style.transform = `translateX(-${targetIndex * 100}%)`;
        currentSlide = targetIndex;
        updateIndicators();
    };

    const nextSlide = () => {
        if (currentSlide === slides.length - 1) {
            moveToSlide(0);
        } else {
            moveToSlide(currentSlide + 1);
        }
    };

    const prevSlide = () => {
        if (currentSlide === 0) {
            moveToSlide(slides.length - 1);
        } else {
            moveToSlide(currentSlide - 1);
        }
    };

    nextButton.addEventListener('click', nextSlide);
    prevButton.addEventListener('click', prevSlide);

    Array.from(indicators).forEach((indicator, index) => {
        indicator.addEventListener('click', () => {
            moveToSlide(index);
        });
    });

    setInterval(nextSlide, 5000); // Cambia cada 5 segundos
});

// location section
function iniciarMap(){
    var coord = {lat:7.1193 ,lng: -73.1227};
    var map = new google.maps.Map(document.getElementById('map'),{
      zoom: 10,
      center: coord
    });
    var marker = new google.maps.Marker({
      position: coord,
      map: map
    });
}