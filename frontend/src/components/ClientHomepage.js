import React, {Fragment, useState, useEffect} from 'react';

const ClientHomepage = ({setAuth} ) => {
    const [name, setName] = useState("");

    async function getName() {
        try {
            const response = await fetch("http://localhost:3000/dashboard/", {
                method: "GET",
                headers: { token: localStorage.token }
            });

            const parseRes = await response.json();
            setName(parseRes.clientfirstname);
        } catch (err) {
            console.error(err.message);
        }
    }

    const logout = (e) => {
        e.preventDefault();
        localStorage.removeItem("token");
        localStorage.removeItem("role");
        setAuth(false);
    }


    useEffect(() => {
        getName();
    }, []);
    
    return (
        <Fragment>
        <h1>Hello {name}</h1>
        <button className="btn btn-danger" onClick={e => logout(e)}>Logout</button>
        </Fragment>
    );
}

export default ClientHomepage;