<script setup>
import { ref, onMounted } from 'vue';
import { AquaAlert_backend } from "../../../declarations/AquaAlert_backend";

const reports = ref([]);
const errorMessage = ref('');

async function fetchReports() {
  try {
    reports.value = await AquaAlert_backend.getReports();
  } catch (error) {
    console.error('Error fetching reports:', error);
    errorMessage.value = 'Failed to fetch reports. Please try again.';
  }
}

onMounted(fetchReports);
</script>

<template>
  <section class="reports-section">
    <h2>Reports</h2>
    <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>
    <ul>
      <li v-for="report in reports" :key="report.id" class="report-item">
        <div class="report-header">
          <strong>ID: {{ report.id }}</strong>
        </div>
        <p class="report-description">Description: {{ report.description }}</p>
        <p>Status: <span :class="['status', report.status.toLowerCase()]">{{ report.status }}</span></p>
        <p>User: {{ report.user.toText() }}</p>
        <p>Timestamp: {{ new Date(Number(report.timestamp) / 1000000).toLocaleString() }}</p>
        <p v-if="report.location">
          Location: {{ report.location.latitude }}, {{ report.location.longitude }}
        </p>
      </li>
    </ul>
  </section>
</template>

<style scoped>
.reports-section {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f8f9fa;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.reports-section h2 {
  font-family: 'Arial', sans-serif;
  font-size: 2rem;
  color: #007BFF;
  margin-bottom: 20px;
  text-align: center;
}

.error-message {
  color: red;
  background-color: #ffebee;
  padding: 10px;
  border-radius: 5px;
  margin-bottom: 20px;
  text-align: center;
  font-family: 'Arial', sans-serif;
}

ul {
  list-style-type: none;
  padding: 0;
}

.report-item {
  border: 1px solid #ddd;
  padding: 15px;
  margin-bottom: 15px;
  border-radius: 10px;
  background-color: white;
  transition: transform 0.2s;
}

.report-item:hover {
  transform: scale(1.02);
}

.report-header {
  font-family: 'Arial', sans-serif;
  font-size: 1.1rem;
  color: #333;
  margin-bottom: 10px;
}

.report-description {
  font-family: 'Arial', sans-serif;
  font-size: 1rem;
  color: #555;
  margin-bottom: 10px;
}

.status {
  font-weight: bold;
}

.status.resolved {
  color: green;
}

.status.pending {
  color: orange;
}

.status.rejected {
  color: red;
}

@media (max-width: 600px) {
  .report-item {
    padding: 10px;
  }
}
</style>
