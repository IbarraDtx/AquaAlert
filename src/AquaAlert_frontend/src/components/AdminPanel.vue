<script setup>
import { ref } from 'vue';
import { AquaAlert_backend } from "../../../declarations/AquaAlert_backend";

const updateStatusId = ref('');
const updateStatusValue = ref('');
const errorMessage = ref('');
const successMessage = ref('');

const statusOptions = ['open', 'in progress', 'resolved', 'closed'];

async function updateStatus() {
  if (updateStatusId.value && updateStatusValue.value) {
    try {
      await AquaAlert_backend.updateStatus(Number(updateStatusId.value), updateStatusValue.value);
      updateStatusId.value = '';
      updateStatusValue.value = '';
      successMessage.value = 'Status updated successfully!';
      setTimeout(() => successMessage.value = '', 3000);
    } catch (error) {
      console.error('Error updating status:', error);
      errorMessage.value = 'Failed to update status. Please check the report ID and try again.';
    }
  }
}
</script>

<template>
  <section class="admin-panel">
    <h2>Admin Panel</h2>
    <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
    <div v-if="successMessage" class="success-message">{{ successMessage }}</div>
    <form @submit.prevent="updateStatus">
      <input v-model="updateStatusId" type="number" placeholder="Report ID" required>
      <select v-model="updateStatusValue" required>
        <option value="" disabled>Select new status</option>
        <option v-for="status in statusOptions" :key="status" :value="status">
          {{ status }}
        </option>
      </select>
      <button type="submit">Update Status</button>
    </form>
  </section>
</template>

<style scoped>
.admin-panel {
  margin-top: 20px;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

form {
  display: flex;
  gap: 10px;
}

input, select {
  padding: 5px;
}
</style>