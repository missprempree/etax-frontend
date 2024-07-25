import './App.css';
import React from 'react';
import axios from 'axios';

function App() {
  
  const handleButtonClick = () => {
    const id = 1;


    axios({
        url: 'http://localhost:9005/api/v1/invoices/'+id+'/download', // replace with your API endpoint
        method: 'GET',
        responseType: 'blob', // important
    }).then((response) => {
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', 'file.xml'); // or any other extension
        document.body.appendChild(link);
        link.click();
    }).catch(error => console.error('Error downloading file : ',error));


    //******************************************** */
    // Call the backend API when the button is clicked
    /*
    fetch('http://localhost:9005/api/v1/invoices/'+id+'/download')
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok.');
        }
        return response.blob();
      }).then(blob => {
        // Create a URL for the blob
        const url = window.URL.createObjectURL(new Blob([blob]));
        // Create a link element
        const link = document.createElement('a');
        link.href = url;
        // Set the filename
        link.setAttribute('download', `invoice_${id}.pdf`);
        // Append the link to the body
        document.body.appendChild(link);
        // Click the link programmatically
        link.click();
        // Remove the link when done
        link.parentNode.removeChild(link);
      }).catch(error => console.error('Error downloading file : ',error));
      */
  };

  return (
    <div className="App">
      <header className="App-header">

        <label>
          Name:
          <input  />
        </label>

        <br/>
        <button class="styled" onClick={handleButtonClick}>Export XML</button>
      </header>
    </div>
  );
}

export default App;
