import React, { Fragment, useState } from 'react';
import {Link} from 'react-router-dom';
import {toast} from 'react-toastify';

const Login = ({ setAuth }) => {
    const [inputs, setInputs] = useState({
        email: '',
        password: '',
        role: '',
    });

    const { email, password, role } = inputs;

    const onChange = (e) => {
        setInputs({ ...inputs, [e.target.name]: e.target.value });
    };

    const onSubmitForm = async (e) => {
        e.preventDefault();
        try {
            const body = { email, password, role };
            const response = await fetch("http://localhost:4000/auth/login", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(body)
            });

            const parseRes = await response.json();
            
            if (parseRes.token) {
                localStorage.setItem("token", parseRes.token);
                localStorage.setItem("role", role);
                setAuth(true, role);
                toast.success("Logged in successfully");
            } else {
                setAuth(false, '');
                toast.error(parseRes);
            }

        } catch (err) {
            console.error(err.message);
        }
    };

    return (
        <Fragment>
            <h1 className="mt-5 text-center">Login</h1>
            <form onSubmit={onSubmitForm}>
                <input type="email" name="email" placeholder="Email" className="form-control my-3" value={email} onChange={onChange} required />
                <input type="password" name="password" placeholder="Password" className="form-control my-3" value={password} onChange={onChange} required />
                <div className="form-check form-check-inline">
                    <input className="form-check-input" type="radio" name="role" id="client" value="client" checked={role === "client"} onChange={onChange} />
                    <label className="form-check-label" htmlFor="client">Client</label>
                </div>
                <div className="form-check form-check-inline">
                    <input className="form-check-input" type="radio" name="role" id="employee" value="employee" checked={role === "employee"} onChange={onChange} />
                    <label className="form-check-label" htmlFor="employee">Employee</label>
                </div>
                <button className="mt-3 btn btn-success btn-block">Submit</button>
            </form>
            <Link to="/signup">Signup</Link>
        </Fragment>
    );
};

export default Login;
