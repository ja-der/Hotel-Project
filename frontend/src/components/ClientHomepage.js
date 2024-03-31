import React, {Fragment} from 'react';

const ClientHomepage = ({setAuth} ) => {
    return (
        <Fragment>
        <h1>Client</h1>
        <button onClick={() => setAuth(false)}>Logout</button>
        </Fragment>
    );
}

export default ClientHomepage;