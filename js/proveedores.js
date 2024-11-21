// Array para almacenar los proveedores registrados
let proveedores = [];

// Función para registrar un nuevo proveedor
function registrarProveedor() {
    const nombreEmpresa = document.getElementById('nombreEmpresa').value;
    const correo = document.getElementById('correo').value;
    const telefono = document.getElementById('telefono').value;

    // Crear un nuevo proveedor con un ID único
    const nuevoProveedor = {
        id: proveedores.length + 1,
        nombreEmpresa: nombreEmpresa,
        correo: correo,
        telefono: telefono
    };

    // Agregar el proveedor al array y actualizar la tabla
    proveedores.push(nuevoProveedor);
    actualizarTablaProveedores();

    // Limpiar formulario y mostrar mensaje de éxito
    document.getElementById('proveedorForm').reset();
    mostrarToast('Proveedor registrado exitosamente');
}

// Función para actualizar la tabla de proveedores
function actualizarTablaProveedores() {
    const proveedorTableBody = document.getElementById('proveedorTableBody');
    proveedorTableBody.innerHTML = '';

    proveedores.forEach(proveedor => {
        const row = document.createElement('tr');

        row.innerHTML = `
            <td>${proveedor.id}</td>
            <td>${proveedor.nombreEmpresa}</td>
            <td>${proveedor.correo}</td>
            <td>${proveedor.telefono}</td>
            <td class="action-buttons">
                <button class="btn btn-sm btn-primary" onclick="editarProveedor(${proveedor.id})">Editar</button>
                <button class="btn btn-sm btn-danger" onclick="eliminarProveedor(${proveedor.id})">Eliminar</button>
            </td>
        `;
        proveedorTableBody.appendChild(row);
    });

    // Aplicar permisos según el rol
    aplicarPermisosProveedores();
}

// Función para editar un proveedor
function editarProveedor(id) {
    const proveedor = proveedores.find(prov => prov.id === id);
    if (!proveedor) return;

    document.getElementById('nombreEmpresa').value = proveedor.nombreEmpresa;
    document.getElementById('correo').value = proveedor.correo;
    document.getElementById('telefono').value = proveedor.telefono;

    document.getElementById('registrarProveedorButton').style.display = 'none';
    document.getElementById('guardarCambiosButton').style.display = 'inline-block';

    document.getElementById('guardarCambiosButton').onclick = function() {
        proveedor.nombreEmpresa = document.getElementById('nombreEmpresa').value;
        proveedor.correo = document.getElementById('correo').value;
        proveedor.telefono = document.getElementById('telefono').value;

        actualizarTablaProveedores();
        mostrarToast('Proveedor actualizado exitosamente');

        // Restaurar el formulario a su estado original
        document.getElementById('proveedorForm').reset();
        document.getElementById('registrarProveedorButton').style.display = 'inline-block';
        document.getElementById('guardarCambiosButton').style.display = 'none';
    };
}

// Función para eliminar un proveedor
function eliminarProveedor(id) {
    proveedores = proveedores.filter(proveedor => proveedor.id !== id);
    actualizarTablaProveedores();
    mostrarToast('Proveedor eliminado exitosamente');
}

// Función para aplicar permisos basados en el rol seleccionado
function aplicarPermisosProveedores() {
    const role = document.getElementById('userRole').value;

    const formContainer = document.getElementById('proveedorFormContainer');
    const actionButtons = document.querySelectorAll('.action-buttons');

    // Controlar visibilidad del formulario según el rol
    if (role === 'administrador' || role === 'vendedor') {
        formContainer.style.display = 'block';
    } else {
        formContainer.style.display = 'none';
    }

    // Controlar las acciones disponibles en la tabla
    actionButtons.forEach(buttons => {
        if (role === 'administrador') {
            buttons.style.display = 'block';
        } else {
            buttons.style.display = 'none';
        }
    });
}

// Función para mostrar el mensaje de éxito
function mostrarToast(mensaje) {
    const toast = document.getElementById('successToast');
    toast.querySelector('.toast-body').textContent = mensaje;
    toast.style.display = 'block';
    setTimeout(() => toast.style.display = 'none', 3000);
}

// Filtrar proveedores en la tabla según la búsqueda
function filterProveedores() {
    const searchInput = document.getElementById('searchProveedor').value.toLowerCase();
    const proveedorTableBody = document.getElementById('proveedorTableBody');

    proveedorTableBody.innerHTML = '';

    proveedores
        .filter(proveedor => proveedor.nombreEmpresa.toLowerCase().includes(searchInput))
        .forEach(proveedor => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${proveedor.id}</td>
                <td>${proveedor.nombreEmpresa}</td>
                <td>${proveedor.correo}</td>
                <td>${proveedor.telefono}</td>
                <td class="action-buttons">
                    <button class="btn btn-sm btn-primary" onclick="editarProveedor(${proveedor.id})">Editar</button>
                    <button class="btn btn-sm btn-danger" onclick="eliminarProveedor(${proveedor.id})">Eliminar</button>
                </td>
            `;
            proveedorTableBody.appendChild(row);
        });
}

// Escuchar cambios en el rol para ajustar permisos
document.getElementById('userRole').addEventListener('change', aplicarPermisosProveedores);

// Ejecutar al cargar la página
document.addEventListener('DOMContentLoaded', () => {
    aplicarPermisosProveedores();
    actualizarTablaProveedores();
});
