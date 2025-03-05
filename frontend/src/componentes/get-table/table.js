import React, { useState, useEffect } from 'react';
import { getUsuarios, getUsuarioByName, deleteUsuarioByName } from '../../servicios/usuarioService';
import './table.css';

function GetComponent() {
    const [usuarios, setUsuarios] = useState([]);
    const [search, setSearch] = useState('');
    const [filteredUsuarios, setFilteredUsuarios] = useState([]);
    const [error, setError] = useState('');

    useEffect(() => {
        // Función para obtener todos los Usuarios
        const fetchUsuarios = async () => {
            try {
                const data = await getUsuarios();
                setUsuarios(data);
                setFilteredUsuarios(data);
            } catch (err) {
                setError(err.message || 'Error al obtener Usuarios');
            }
        };

        fetchUsuarios();
    }, []);

    const handleSearch = async () => {
        if (search) {
            try {
                const data = await getUsuarioByName(search);
                if (data) {
                    setFilteredUsuarios([data]);
                    setError(''); // Limpiar mensaje de error
                } else {
                    setFilteredUsuarios([]);
                    setError('No se encontraron coincidencias.');
                }
            } catch (err) {
                setFilteredUsuarios([]);
                setError('Error al buscar contacto');
            }
        } else {
            // Mostrar todos los Usuarios si el campo de búsqueda está vacío
            setFilteredUsuarios(usuarios);
            setError(''); // Limpiar mensaje de error
        }
    };

    const handleDelete = async (name) => {
        try {
            await deleteUsuarioByName(name);
            setUsuarios(usuarios.filter(usuario => usuario.name !== name)); // Actualizar lista de usuarios sin el eliminado
            setFilteredUsuarios(filteredUsuarios.filter(usuario => usuario.name !== name));
            setError(''); // Limpiar mensaje de error
        } catch (err) {
            setError('Error al eliminar usuario');
        }
    };

    return (
        <div className="table-container">
            <h1>Usuarios</h1>
            <div className="search-container">
                <input
                    type="text"
                    placeholder="Buscar por nombre"
                    value={search}
                    onChange={(e) => setSearch(e.target.value)}
                    className="search-input"
                />
                <button onClick={handleSearch} className="search-button">Buscar</button>
            </div>
            {error && <p className="error-message">{error}</p>}
            <table className="contact-table">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    {filteredUsuarios.length > 0 ? (
                        filteredUsuarios.map((usuario, index) => (
                            <tr key={index}>
                                <td>{usuario.name}</td>
                                <td>{usuario.email}</td>
                                <td>
                                    <button
                                        onClick={() => handleDelete(usuario.name)}
                                        className="delete-button"
                                    >
                                        Eliminar
                                    </button>
                                </td>
                            </tr>
                        ))
                    ) : (
                        <tr>
                            <td colSpan="3">No hay Usuarios</td>
                        </tr>
                    )}
                </tbody>
            </table>
        </div>
    );
}

export default GetComponent;