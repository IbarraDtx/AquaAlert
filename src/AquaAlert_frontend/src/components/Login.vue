<script setup>
import { AuthClient } from "@dfinity/auth-client";

const emit = defineEmits(['login']);

async function login() {
  const authClient = await AuthClient.create();
  await new Promise((resolve) => {
    authClient.login({
      identityProvider: "https://identity.ic0.app",
      onSuccess: resolve,
    });
  });
  emit('login');
}
</script>

<template>
  <div class="welcome-container">
    <h1>Welcome to AquaAlert</h1>
    <p>Your reliable platform for water incident reporting and management.</p>
    <button class="btn-login" @click="login">Login with Internet Identity</button>
  </div>
</template>

<style scoped>
/* Estilos globales aquí */
.welcome-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  text-align: center;
  background: linear-gradient(to right, #6dd5ed, #2193b0); /* Gradiente de fondo */
  color: white;
  padding: 20px;
}

h1 {
  font-family: 'Arial', sans-serif;
  font-size: 2.5rem;
  margin-bottom: 20px;
}

p {
  font-family: 'Arial', sans-serif;
  font-size: 1.2rem;
  margin-bottom: 40px;
}

.btn-login {
  background-color: #007BFF;
  color: white;
  padding: 15px 30px;
  border: none;
  border-radius: 5px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.btn-login:hover {
  background-color: #0056b3;
}
</style>
