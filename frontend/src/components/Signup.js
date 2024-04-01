import React, { Fragment, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';

const Signup = () => {
  const navigate = useNavigate();

  const [inputs, setInputs] = useState({
    firstName: '',
    lastName: '',
    address: '',
    ssn: 0,
    email: '',
    password: ''
  });

  const { firstName, lastName, address, ssn, email, password } = inputs;

  const onChange = e => {
    setInputs({ ...inputs, [e.target.name]: e.target.value });
  };

  const onSubmitForm = async e => {
    e.preventDefault();
    try {
      const date = new Date();
      const registrationDate =
        date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate();
      const body = {
        firstName,
        lastName,
        address,
        ssn,
        registrationDate,
        email,
        password
      };
      const response = await fetch('http://localhost:4000/auth/signup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(body)
      });
      
      // Redirect to login page after successful signup
        if (response.status === 200) {
            toast.success('Signed up sucessfully!');
            navigate('/login');
        }
    } catch (err) {
      console.error(err.message);
    }
  };

  return (
    <Fragment>
      <h1 className="mt-5 text-center">Signup</h1>
      <form onSubmit={onSubmitForm}>
        <input
          type="text"
          name="firstName"
          placeholder="First Name"
          className="form-control my-3"
          onChange={e => onChange(e)}
          required
        />
        <input
          type="text"
          name="lastName"
          placeholder="Last Name"
          className="form-control my-3"
          onChange={e => onChange(e)}
          required
        />
        <input
          type="text"
          name="address"
          placeholder="Address"
          className="form-control my-3"
          onChange={e => onChange(e)}
          required
        />
        <input
          type="number"
          name="ssn"
          placeholder="SSN"
          className="form-control my-3"
          onChange={e => onChange(e)}
          required
        />
        <input
          type="email"
          name="email"
          placeholder="Email"
          className="form-control my-3"
          onChange={e => onChange(e)}
          required
        />
        <input
          type="password"
          name="password"
          placeholder="Password"
          className="form-control my-3"
          onChange={e => onChange(e)}
          required
        />
        <button className="btn btn-success btn-block">Submit</button>
      </form>
      <Link to="/login">Login</Link>
    </Fragment>
  );
};

export default Signup;
