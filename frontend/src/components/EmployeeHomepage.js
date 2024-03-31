import React, {Fragment} from 'react';

const EmployeeHomepage = ({setAuth} ) => {
    return (
        <Fragment>
        <h1>Employee</h1>
        <button onClick={() => setAuth(false)}>Logout</button>
        </Fragment>
    );
}

export default EmployeeHomepage;