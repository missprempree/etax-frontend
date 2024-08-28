import './App1.css';
import axios from 'axios';
import React, { useState } from 'react';

function App() {
  
  const [inputValue, setInputValue] = useState(''); // set {inputValue} to empty string initially

  const handleSubmit = (e) => {
    e.preventDefault();
    // You can perform further actions with the input value here
    axios({
        url: 'http://etax-new-project-yatphiroon.apps.dc1.test.local/api/v1/invoices/'+inputValue+'/export', 
        method: 'GET',
        responseType: 'blob', // important
    }).then((response) => {
        if(response.data.size === 0){
            alert("No data found for the given id : " + inputValue);
            return false;
        } 
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;

        const now = new Date();
        const randomNumber = now.getTime(); // Get the current timestamp in milliseconds
        link.setAttribute('download', 'INV' + inputValue + '_' + randomNumber + '.xml');

        // link.setAttribute('download', 'invoice' + inputValue + '.xml'); // or any other extension
        document.body.appendChild(link);
        link.click();
    }).catch(error => console.error('Error downloading file : ',error));

  };

  const handleChange = (e) => {
    const value = e.target.value;
    // Check if the value is an integer (whole number) or empty
    if (/^\d*$/.test(value)) {
      setInputValue(value); // Update input value only if it's an integer or empty
    }
  };

  return (
    <div className="center">
      <section>
      <div className="image-container">
        <img src="https://etax.rd.go.th/etax_staticpage/app/homepage/images/logo.png"
           alt="etax logo" />
      </div>  
      <form onSubmit={handleSubmit}>
        <input
          type="number"
          className="modern-input"
          value={inputValue}
          onChange={handleChange}
          placeholder="Enter Id"
        /><button type="submit" class="modern-button" >Export</button>
      </form>
      </section>
    </div>
  );
}

export default App;
