import Usuario from "../modelos/usuario";

const API_BASE_URL = "http://localhost:8080";

export const addUsuario = async (usuario) => {
    const response = await fetch(`${API_BASE_URL}/users`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(usuario)
    });

    if (!response.ok) {
        throw new Error("Error al agregar usuario");
    }

    return response.json();
}

export const getUsuarios = async () => {
    const response = await fetch(`${API_BASE_URL}/users`);

    if (!response.ok) {
        throw new Error("Error al obtener usuarios");
    }

    const usuarios = await response.json();
    return usuarios.map(usuario => new Usuario(usuario.name, usuario.email));
}

export const deleteUsuarioByName = async (name) => {
    const response = await fetch(`${API_BASE_URL}/users/${name}`, {
        method: "DELETE"
    });

    if (!response.ok) {
        throw new Error("Error al eliminar usuario");
    }
}

export const getUsuarioByName = async (name) => {
    const response = await fetch(`${API_BASE_URL}/users/${name}`);

    if (!response.ok) {
        throw new Error("Error al obtener usuario");
    }

    const usuario = await response.json();
    return new Usuario(usuario.name, usuario.email);
}