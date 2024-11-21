// Función para cargar el menú desde un archivo externo
function loadMenu() {
    fetch('../menu.html')
        .then(response => response.text())
        .then(data => {
            document.getElementById('sidebar').innerHTML = data;
        })
        .catch(error => {
            console.error('Error al cargar el menú:', error);
        });
}

// Cargar el menú cuando la página esté lista
window.onload = loadMenu;
