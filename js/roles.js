// Función que se ejecuta al seleccionar un rol
document.getElementById('userRole').addEventListener('change', function() {
    let selectedRole = this.value;
    manageClientSection(selectedRole);
});

// Función para gestionar el contenido de la sección de Clientes según el rol seleccionado
function manageClientSection(role) {
    // Mostrar/ocultar el título del formulario de registro de cliente
    const title = document.querySelector('h1');
    title.textContent = (role === 'administrador' || role === 'vendedor') ? 'Registro de Cliente' : 'Visualización de Cliente';

    // Mostrar/ocultar el formulario de registro de cliente
    const clientForm = document.getElementById('clientForm');
    if (role === 'administrador' || role === 'vendedor') {
        clientForm.style.display = 'block';  // Mostrar formulario solo a Administrador y Vendedor
    } else {
        clientForm.style.display = 'none';  // Ocultar para el rol de Contador
    }

    // Habilitar las acciones para Administrador y Vendedor
    const actionsColumn = document.querySelectorAll('.action-buttons');
    if (role === 'administrador') {
        // Los administradores pueden ver, editar y eliminar clientes
        actionsColumn.forEach(column => column.style.display = 'block');
    } else if (role === 'vendedor') {
        // Los vendedores solo pueden ver y registrar, sin editar ni eliminar
        actionsColumn.forEach(column => column.style.display = 'none');
    } else if (role === 'contador') {
        // Los contadores solo pueden ver los clientes, sin acciones
        actionsColumn.forEach(column => column.style.display = 'none');
    }

    // Cambiar la imagen de acuerdo con el rol
    const roleImage = document.getElementById('roleImage');
    const roleImageContainer = document.getElementById('roleImageContainer');
    if (role === 'administrador') {
        roleImage.src = 'img/administrador.png';
    } else if (role === 'vendedor') {
        roleImage.src = 'img/vendedor.png';
    } else if (role === 'contador') {
        roleImage.src = 'img/contador.png';
    }

    // Asegurarse de que la imagen se muestre
    roleImageContainer.style.display = 'block';
}

// Filtrar los clientes según el texto de búsqueda
function filterClients() {
    const searchValue = document.getElementById('searchClient').value.toLowerCase();
    const clientRows = document.querySelectorAll('#clientTableBody tr');
    clientRows.forEach(row => {
        const clientName = row.cells[1].textContent.toLowerCase();
        if (clientName.includes(searchValue)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

// Función para ordenar los clientes por nombre
function sortClients() {
    const rows = Array.from(document.querySelectorAll('#clientTableBody tr'));
    rows.sort((a, b) => {
        const nameA = a.cells[1].textContent.toLowerCase();
        const nameB = b.cells[1].textContent.toLowerCase();
        return nameA.localeCompare(nameB);
    });
    const tbody = document.getElementById('clientTableBody');
    tbody.innerHTML = '';
    rows.forEach(row => tbody.appendChild(row));
}

// Función para registrar un cliente (simulada)
function registerClient() {
    const clientName = document.getElementById('clientName').value;
    const phone = document.getElementById('phone').value;
    const email = document.getElementById('email').value;
    const address = document.getElementById('address').value;
    const preferredPaymentMethod = document.getElementById('preferredPaymentMethod').value;

    // Aquí deberías agregar la lógica para registrar el cliente en el sistema

    // Mostrar notificación de éxito
    const successToast = document.getElementById('successToast');
    successToast.style.display = 'block';
    setTimeout(() => {
        successToast.style.display = 'none';
    }, 3000);
}
