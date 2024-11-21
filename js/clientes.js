// Datos de clientes (simulando una base de datos en memoria)
let clients = [];
let clientId = 1;

// Función para registrar un nuevo cliente
function registerClient() {
    // Obtener valores del formulario
    const name = document.getElementById('clientName').value;
    const phone = document.getElementById('phone').value;
    const email = document.getElementById('email').value;
    const address = document.getElementById('address').value;
    const paymentMethod = document.getElementById('preferredPaymentMethod').value;
    const registrationDate = new Date().toLocaleDateString();

    // Crear objeto cliente
    const client = {
        id: clientId++,
        name,
        phone,
        email,
        address,
        paymentMethod,
        registrationDate
    };

    // Añadir cliente a la "base de datos"
    clients.push(client);

    // Limpiar formulario y mostrar notificación de éxito
    document.getElementById('clientForm').reset();
    showSuccessToast();

    // Actualizar tabla de clientes
    displayClients();
}

// Función para mostrar la notificación de éxito
function showSuccessToast() {
    const toast = document.getElementById('successToast');
    toast.style.display = 'block';
    setTimeout(() => {
        toast.style.display = 'none';
    }, 3000);
}

// Función para mostrar la lista de clientes
function displayClients() {
    const clientTableBody = document.getElementById('clientTableBody');
    clientTableBody.innerHTML = '';

    clients.forEach(client => {
        const row = document.createElement('tr');
        
        row.innerHTML = `
            <td>${client.id}</td>
            <td>${client.name}</td>
            <td>${client.phone}</td>
            <td>${client.email}</td>
            <td>${client.address}</td>
            <td>${client.paymentMethod}</td>
            <td class="action-buttons">
                <button class="btn btn-primary btn-sm me-1" onclick="editClient(${client.id})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-danger btn-sm" onclick="deleteClient(${client.id})"><i class="fas fa-trash-alt"></i></button>
            </td>
        `;

        clientTableBody.appendChild(row);
    });

    manageRolePermissions();
}

// Función para editar un cliente
function editClient(id) {
    const client = clients.find(c => c.id === id);
    if (!client) return;

    // Llenar formulario con los datos del cliente para editar
    document.getElementById('clientName').value = client.name;
    document.getElementById('phone').value = client.phone;
    document.getElementById('email').value = client.email;
    document.getElementById('address').value = client.address;
    document.getElementById('preferredPaymentMethod').value = client.paymentMethod;

    // Cambiar el botón para actualizar el cliente
    document.getElementById('clientFormContainer').innerHTML += `
        <button type="button" class="btn btn-warning mt-2" onclick="updateClient(${id})">Actualizar Cliente</button>
    `;
}

// Función para actualizar un cliente después de la edición
function updateClient(id) {
    const client = clients.find(c => c.id === id);
    if (!client) return;

    // Actualizar datos del cliente con los valores del formulario
    client.name = document.getElementById('clientName').value;
    client.phone = document.getElementById('phone').value;
    client.email = document.getElementById('email').value;
    client.address = document.getElementById('address').value;
    client.paymentMethod = document.getElementById('preferredPaymentMethod').value;

    // Limpiar el formulario y restablecer el botón
    document.getElementById('clientForm').reset();
    displayClients();
}

// Función para eliminar un cliente
function deleteClient(id) {
    clients = clients.filter(client => client.id !== id);
    displayClients();
}

// Función para filtrar clientes
function filterClients() {
    const searchValue = document.getElementById('searchClient').value.toLowerCase();
    const filteredClients = clients.filter(client =>
        client.name.toLowerCase().includes(searchValue) ||
        client.phone.includes(searchValue) ||
        client.email.toLowerCase().includes(searchValue) ||
        client.address.toLowerCase().includes(searchValue)
    );

    displayFilteredClients(filteredClients);
}

// Función para mostrar solo los clientes filtrados
function displayFilteredClients(filteredClients) {
    const clientTableBody = document.getElementById('clientTableBody');
    clientTableBody.innerHTML = '';

    filteredClients.forEach(client => {
        const row = document.createElement('tr');
        
        row.innerHTML = `
            <td>${client.id}</td>
            <td>${client.name}</td>
            <td>${client.phone}</td>
            <td>${client.email}</td>
            <td>${client.address}</td>
            <td>${client.paymentMethod}</td>
            <td class="action-buttons">
                <button class="btn btn-primary btn-sm me-1" onclick="editClient(${client.id})"><i class="fas fa-edit"></i></button>
                <button class="btn btn-danger btn-sm" onclick="deleteClient(${client.id})"><i class="fas fa-trash-alt"></i></button>
            </td>
        `;

        clientTableBody.appendChild(row);
    });

    manageRolePermissions();
}

// Función para ordenar clientes alfabéticamente por nombre
function sortClients() {
    clients.sort((a, b) => a.name.localeCompare(b.name));
    displayClients();
}

// Función para manejar permisos según el rol
function manageRolePermissions() {
    const userRole = document.getElementById('userRole').value;

    const formContainer = document.getElementById('clientFormContainer');
    const actionButtons = document.querySelectorAll('.action-buttons');

    if (userRole === 'administrador') {
        formContainer.style.display = 'block';
        actionButtons.forEach(btn => btn.style.display = 'block');
    } else if (userRole === 'vendedor') {
        formContainer.style.display = 'block';
        actionButtons.forEach(btn => btn.style.display = 'none');  // Solo registrar
    } else if (userRole === 'contador') {
        formContainer.style.display = 'none';
        actionButtons.forEach(btn => btn.style.display = 'none');  // Solo ver
    }
}

// Inicializar vista de clientes al cargar la página
window.onload = displayClients;
