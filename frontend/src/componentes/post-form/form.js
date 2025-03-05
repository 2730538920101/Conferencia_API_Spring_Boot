import React, { useState } from 'react';
import { addUsuario } from '../../servicios/usuarioService';
import './form.css';

// Componente para el formulario de registro de contacto
function PostComponent() {
    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [message, setMessage] = useState('');

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            const result = await addUsuario({ name, email });

            setMessage({ type: 'success', text: "se agrego correctamente el usuario", result: JSON.stringify(result) });
            setName('');
            setEmail('');
        } catch (err) {
            setMessage({ type: 'error', text: JSON.stringify(err.message || 'Error al enviar el formulario') });
        }
    };

    return (
        <div className="form-container">
            <h1>Registrar Contacto</h1>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label htmlFor="nombre">Nombre:</label>
                    <input
                        type="text"
                        id="nombre"
                        value={name}
                        onChange={(e) => setName(e.target.value)}
                        required
                    />
                </div>
                <div className="form-group">
                    <label htmlFor="email">Email:</label>
                    <input
                        type="email"
                        id="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                    />
                </div>
                <button type="submit">Registrar</button>
            </form>
            {message && <p className={message.type === 'error' ? 'error-message' : 'success-message'}>{message.text}</p>}
        </div>
    );
}

export default PostComponent;