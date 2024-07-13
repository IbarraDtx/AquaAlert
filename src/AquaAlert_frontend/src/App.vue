<script setup>
import { ref, onMounted } from 'vue';
import { AuthClient } from "@dfinity/auth-client";
import { AquaAlert_backend } from "../../declarations/AquaAlert_backend";
import Login from './components/Login.vue';
import ReportForm from './components/ReportForm.vue';
import ReportList from './components/ReportList.vue';
import AdminPanel from './components/AdminPanel.vue';

const authClient = ref(null);
const isAuthenticated = ref(false);
const userRole = ref(null);
const errorMessage = ref('');
const successMessage = ref('');

async function initAuth() {
  authClient.value = await AuthClient.create();
  const isLoggedIn = await authClient.value.isAuthenticated();
  isAuthenticated.value = isLoggedIn;
  if (isLoggedIn) {
    await login();
  }
}

async function login() {
  try {
    await AquaAlert_backend.login();
    userRole.value = await AquaAlert_backend.getRole();
    isAuthenticated.value = true;
    successMessage.value = 'Logged in successfully!';
  } catch (error) {
    console.error('Login error:', error);
    errorMessage.value = 'Failed to login. Please try again.';
  }
}

async function logout() {
  await authClient.value.logout();
  isAuthenticated.value = false;
  userRole.value = null;
  successMessage.value = 'Logged out successfully!';
}

onMounted(initAuth);
</script>

<template>
  <main>
    <h1 class="title">AquaAlert</h1>
    <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
    <div v-if="successMessage" class="success-message">{{ successMessage }}</div>
    <Login v-if="!isAuthenticated" @login="login" />
    <div v-else>
      <p>Welcome, {{ userRole === '#Admin' ? 'Admin' : 'User' }}!</p>
      <button class="btn-logout" @click="logout">Logout</button>
      <ReportForm />
      <AdminPanel v-if="userRole === '#Admin'" />
      <ReportList />
    </div>
  </main>
</template>

<style scoped>
/* Estilos globales aquí */
.title {
  font-family: 'Arial', sans-serif;
  font-size: 2.5rem;
  font-weight: bold;
  color: #007BFF;
  text-align: center;
  margin-top: 20px;
  margin-bottom: 40px;
}

.error-message {
  color: red;
  background-color: #ffebee;
  padding: 10px;
  border-radius: 4px;
  margin-bottom: 10px;
}

.success-message {
  color: green;
  background-color: #e8f5e9;
  padding: 10px;
  border-radius: 4px;
  margin-bottom: 10px;
}

.btn-logout {
  background-color: #007BFF;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 1rem;
  margin-bottom: 20px;
}

.btn-logout:hover {
  background-color: #0056b3;
}
</style>
