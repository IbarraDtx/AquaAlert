<script setup>
import { ref } from 'vue';
import { AquaAlert_backend } from "../../../declarations/AquaAlert_backend";
import { AuthClient } from "@dfinity/auth-client";

const description = ref('');
const location = ref(null);
const errorMessage = ref('');
const successMessage = ref('');

async function addReport() {
  if (description.value) {
    try {
      if (!location.value) {
        errorMessage.value = 'Please get your location before submitting the report.';
        return;
      }

      const authClient = await AuthClient.create();
      const identity = await authClient.getIdentity();
      const principal = identity.getPrincipal();

      await AquaAlert_backend.addReport(description.value, location.value, principal);
      description.value = '';
      location.value = null;
      successMessage.value = 'Report added successfully!';
      setTimeout(() => successMessage.value = '', 3000);
    } catch (error) {
      console.error('Error adding report:', error);
      errorMessage.value = `Failed to add report: ${error.message || 'Unknown error'}`;
    }
  }
}

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        location.value = {
          latitude: position.coords.latitude,
          longitude: position.coords.longitude
        };
        successMessage.value = 'Location retrieved successfully!';
        setTimeout(() => successMessage.value = '', 3000);
      },
      (error) => {
        console.error('Geolocation error:', error);
        errorMessage.value = `Unable to retrieve your location: ${error.message}`;
      },
      {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
      }
    );
  } else {
    errorMessage.value = 'Geolocation is not supported by your browser';
  }
}
</script>

<template>
  <section class="form-section">
    <h2>Add New Report</h2>
    <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
    <div v-if="successMessage" class="success-message">{{ successMessage }}</div>
    <form @submit.prevent="addReport">
      <textarea v-model="description" placeholder="Report description" required></textarea>
      <button type="button" @click="getLocation">Get Current Location</button>
      <button type="submit">Add Report</button>
    </form>
  </section>
</template>

<style scoped>
/* Estilos globales aquí */
.form-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #f8f9fa; /* Fondo claro */
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  max-width: 600px;
  margin: 0 auto;
}

h2 {
  font-family: 'Arial', sans-serif;
  font-size: 2rem;
  color: #007BFF;
  margin-bottom: 20px;
}

textarea {
  width: 100%;
  height: 100px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin-bottom: 10px;
  font-family: 'Arial', sans-serif;
  font-size: 1rem;
}

button {
  background-color: #007BFF;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1rem;
  margin-bottom: 10px;
  transition: background-color 0.3s ease;
}

button[type="button"] {
  margin-right: 10px;
}

button:hover {
  background-color: #0056b3;
}

.error-message, .success-message {
  width: 100%;
  padding: 10px;
  border-radius: 5px;
  margin-bottom: 10px;
  text-align: center;
  font-family: 'Arial', sans-serif;
}

.error-message {
  color: red;
  background-color: #ffebee;
}

.success-message {
  color: green;
  background-color: #e8f5e9;
}
</style>
