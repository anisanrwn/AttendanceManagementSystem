'use strict';

(function () {
  let cardColor, headingColor, axisColor, shadeColor, borderColor;

  cardColor = config.colors.white;
  headingColor = config.colors.headingColor;
  axisColor = config.colors.axisColor;
  borderColor = config.colors.borderColor;

  // 1. Department Attendance Chart

  async function loadTopAbsentChart() {
    const el = document.querySelector("#topAbsentChart");
    if (!el) return;

    try {
      const res = await fetch('http://localhost:8000/dashboard/top-absent');
      const data = await res.json();

      const names = data.map(d => d.name);
      const values = data.map(d => d.absent_count);

      const options = {
        chart: { type: 'bar', height: 350 },
        series: [{ name: 'Absent Days', data: values }],
        xaxis: {
          categories: names,
          labels: { style: { fontSize: '13px', colors: axisColor } }
        },
        colors: [config.colors.primary],
        fill: {
          opacity: 1,
          type: 'gradient',
          gradient: {
            shade: 'light',
            type: 'vertical',
            shadeIntensity: 0.3,
            opacityFrom: 1,
            opacityTo: 0.7,
            stops: [0, 80]
          }
        },
        plotOptions: {
          bar: {
            horizontal: true,
            borderRadius: 8,
            barHeight: '60%'
          }
        },
        dataLabels: { enabled: false },
        tooltip: {
          y: { formatter: val => `${val} kali absen` }
        },
        legend: { labels: { colors: axisColor } }
      };

      new ApexCharts(el, options).render();
    } catch (err) {
      console.error("Error loading top absent chart:", err);
    }
  }

  // 2. Attendance Trend Chart
  async function loadAttendanceTrendChart() {
    const el = document.querySelector("#attendanceRateChart");
    if (!el) return;

    try {
      const res = await fetch('http://localhost:8000/dashboard/attendance-trend');
      const data = await res.json();

      const allowedStatuses = ["Punch Out", "Absent", "Permit"];
      const filteredData = data.filter(item => allowedStatuses.includes(item.status));

      const dates = [...new Set(filteredData.map(item => item.month))].sort();
      const statuses = [...new Set(filteredData.map(item => item.status))];

      const series = statuses.map(status => ({
        name: status,
        data: dates.map(date => {
          const record = data.find(d => d.month === date && d.status === status);
          return record ? record.count : 0;
        })
      }));

      const options = {
        chart: { type: 'bar', height: 350, stacked: true },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '20%',
            borderRadius: 12,
            startingShape: 'rounded',
            endingShape: 'rounded'
          }
        },
        stroke: {
          curve: 'smooth',
          width: 6,
          lineCap: 'round',
          colors: [cardColor]
        },
        dataLabels: { enabled: false },
        series,
        xaxis: {
          categories: dates,
          labels: { style: { fontSize: '13px', colors: axisColor } }
        },
        legend: {
          labels: { colors: axisColor },
          position: 'top',
        },
        colors: [config.colors.primary, config.colors.skycolor, config.colors.bluecolor],
      };

      new ApexCharts(el, options).render();
    } catch (error) {
      console.error("Error loading attendance trend chart:", error);
    }
  }

  // 3. Working Hours Chart
  async function loadWorkingHoursChart() {
    const el = document.querySelector('#weeklyWorkingHoursChart');
    if (!el) return;

    const employeeId = sessionStorage.getItem('employee_id');
    if (!employeeId) {
      console.error('employee_id not found in sessionStorage');
      return;
    }

    try {
      const response = await fetch(`http://localhost:8000/dashboard/weekly-working-hours/${employeeId}`);
      const data = await response.json();

      const options = {
        chart: { type: 'area', height: 300 },
        colors: [config.colors.primary],
        dataLabels: { enabled: false },
        stroke: { curve: 'smooth', width: 3 },
        markers: { size: 4, strokeWidth: 0, hover: { size: 6 } },
        xaxis: {
          categories: data.labels,
          labels: { style: { fontSize: '13px', colors: axisColor } }
        },
        tooltip: {
          y: { formatter: val => `${val.toFixed(2)} hours` }
        },
        fill: {
          type: 'gradient',
          gradient: {
            shade: shadeColor,
            shadeIntensity: 0.6,
            opacityFrom: 0.5,
            opacityTo: 0.25,
            stops: [0, 95, 100]
          }
        },
        series: [{ name: 'Working Hours', data: data.series }]
      };

      new ApexCharts(el, options).render();
    } catch (error) {
      console.error('Failed to load working hours data:', error);
    }
  }

  // 4. Monthly Attendance Chart
  async function loadMonthlyAttendanceChart() {
    const el = document.querySelector('#monthlyAttendanceChart');
    if (!el) return;

    const employeeId = sessionStorage.getItem('employee_id');
    if (!employeeId) {
      console.error('employee_id not found in sessionStorage');
      return;
    }

    try {
      const response = await fetch(`http://localhost:8000/dashboard/monthly-attendance/${employeeId}`);
      const data = await response.json();

      const options = {
        chart: { type: 'bar', height: 300, stacked: true },
        colors: [config.colors.primary, config.colors.skycolor, config.colors.bluecolor],
        series: data.series,
        xaxis: {
          categories: data.labels,
          labels: { style: { fontSize: '13px', colors: axisColor } }
        },
        legend: {
          position: 'top',
          horizontalAlign: 'center',
          labels: { colors: axisColor }
        },
        tooltip: { y: { formatter: val => `${val} days` } },
        stroke: {
          curve: 'smooth',
          width: 2,
          lineCap: 'round',
          colors: [cardColor]
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '50%',
            borderRadius: 3,
            startingShape: 'rounded',
            endingShape: 'rounded'
          }
        },
        dataLabels: { enabled: false }
      };

      new ApexCharts(el, options).render();
    } catch (error) {
      console.error('Failed to load monthly attendance data:', error);
    }
  }
  loadTopAbsentChart();
  loadAttendanceTrendChart();
  loadWorkingHoursChart();
  loadMonthlyAttendanceChart();
})();
