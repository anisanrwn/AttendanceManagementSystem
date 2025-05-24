
'use strict';

(function () {
  let cardColor, headingColor, axisColor, shadeColor, borderColor;

  cardColor = config.colors.white;
  headingColor = config.colors.headingColor;
  axisColor = config.colors.axisColor;
  borderColor = config.colors.borderColor;

  // Total Revenue Report Chart - Bar Chart
  // --------------------------------------------------------------------
  const totalRevenueChartEl = document.querySelector('#totalRevenueChart'),
    totalRevenueChartOptions = {
      series: [
        {
          name: '2021',
          data: [18, 7, 15, 29, 18, 12, 9]
        },
        {
          name: '2020',
          data: [-13, -18, -9, -14, -5, -17, -15]
        }
      ],
      chart: {
        height: 300,
        stacked: true,
        type: 'bar',
        toolbar: { show: false }
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: '33%',
          borderRadius: 12,
          startingShape: 'rounded',
          endingShape: 'rounded'
        }
      },
      colors: [config.colors.primary, config.colors.info],
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'smooth',
        width: 6,
        lineCap: 'round',
        colors: [cardColor]
      },
      legend: {
        show: true,
        horizontalAlign: 'left',
        position: 'top',
        markers: {
          height: 8,
          width: 8,
          radius: 12,
          offsetX: -3
        },
        labels: {
          colors: axisColor
        },
        itemMargin: {
          horizontal: 10
        }
      },
      grid: {
        borderColor: borderColor,
        padding: {
          top: 0,
          bottom: -8,
          left: 20,
          right: 20
        }
      },
      xaxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
        labels: {
          style: {
            fontSize: '13px',
            colors: axisColor
          }
        },
        axisTicks: {
          show: false
        },
        axisBorder: {
          show: false
        }
      },
      yaxis: {
        labels: {
          style: {
            fontSize: '13px',
            colors: axisColor
          }
        }
      },
      responsive: [
        {
          breakpoint: 1700,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '32%'
              }
            }
          }
        },
        {
          breakpoint: 1580,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '35%'
              }
            }
          }
        },
        {
          breakpoint: 1440,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '42%'
              }
            }
          }
        },
        {
          breakpoint: 1300,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '48%'
              }
            }
          }
        },
        {
          breakpoint: 1200,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '40%'
              }
            }
          }
        },
        {
          breakpoint: 1040,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 11,
                columnWidth: '48%'
              }
            }
          }
        },
        {
          breakpoint: 991,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '30%'
              }
            }
          }
        },
        {
          breakpoint: 840,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '35%'
              }
            }
          }
        },
        {
          breakpoint: 768,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '28%'
              }
            }
          }
        },
        {
          breakpoint: 640,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '32%'
              }
            }
          }
        },
        {
          breakpoint: 576,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '37%'
              }
            }
          }
        },
        {
          breakpoint: 480,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '45%'
              }
            }
          }
        },
        {
          breakpoint: 420,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '52%'
              }
            }
          }
        },
        {
          breakpoint: 380,
          options: {
            plotOptions: {
              bar: {
                borderRadius: 10,
                columnWidth: '60%'
              }
            }
          }
        }
      ],
      states: {
        hover: {
          filter: {
            type: 'none'
          }
        },
        active: {
          filter: {
            type: 'none'
          }
        }
      }
    };
  if (typeof totalRevenueChartEl !== undefined && totalRevenueChartEl !== null) {
    const totalRevenueChart = new ApexCharts(totalRevenueChartEl, totalRevenueChartOptions);
    totalRevenueChart.render();
  }

  // Growth Chart - Radial Bar Chart
  // --------------------------------------------------------------------
  const growthChartEl = document.querySelector('#growthChart'),
    growthChartOptions = {
      series: [78],
      labels: ['7h of 8h'],
      chart: {
        height: 240,
        type: 'radialBar'
      },
      plotOptions: {
        radialBar: {
          size: 150,
          offsetY: 10,
          startAngle: -150,
          endAngle: 150,
          hollow: {
            size: '55%'
          },
          track: {
            background: cardColor,
            strokeWidth: '100%'
          },
          dataLabels: {
            name: {
              offsetY: 15,
              color: headingColor,
              fontSize: '15px',
              fontWeight: '600',
              fontFamily: 'Public Sans'
            },
            value: {
              offsetY: -25,
              color: headingColor,
              fontSize: '22px',
              fontWeight: '500',
              fontFamily: 'Public Sans'
            }
          }
        }
      },
      colors: [config.colors.primary],
      fill: {
        type: 'gradient',
        gradient: {
          shade: 'dark',
          shadeIntensity: 0.5,
          gradientToColors: [config.colors.primary],
          inverseColors: true,
          opacityFrom: 1,
          opacityTo: 0.6,
          stops: [30, 70, 100]
        }
      },
      stroke: {
        dashArray: 5
      },
      grid: {
        padding: {
          top: -35,
          bottom: -10
        }
      },
      states: {
        hover: {
          filter: {
            type: 'none'
          }
        },
        active: {
          filter: {
            type: 'none'
          }
        }
      }
    };
  if (typeof growthChartEl !== undefined && growthChartEl !== null) {
    const growthChart = new ApexCharts(growthChartEl, growthChartOptions);
    growthChart.render();
  }

  // Profit Report Line Chart
  // --------------------------------------------------------------------
  const profileReportChartEl = document.querySelector('#profileReportChart'),
    profileReportChartConfig = {
      chart: {
        height: 80,
        // width: 175,
        type: 'line',
        toolbar: {
          show: false
        },
        dropShadow: {
          enabled: true,
          top: 10,
          left: 5,
          blur: 3,
          color: config.colors.warning,
          opacity: 0.15
        },
        sparkline: {
          enabled: true
        }
      },
      grid: {
        show: false,
        padding: {
          right: 8
        }
      },
      colors: [config.colors.warning],
      dataLabels: {
        enabled: false
      },
      stroke: {
        width: 5,
        curve: 'smooth'
      },
      series: [
        {
          data: [110, 270, 145, 245, 205, 285]
        }
      ],
      xaxis: {
        show: false,
        lines: {
          show: false
        },
        labels: {
          show: false
        },
        axisBorder: {
          show: false
        }
      },
      yaxis: {
        show: false
      }
    };
  if (typeof profileReportChartEl !== undefined && profileReportChartEl !== null) {
    const profileReportChart = new ApexCharts(profileReportChartEl, profileReportChartConfig);
    profileReportChart.render();
  }

  // Order Statistics Chart
  // --------------------------------------------------------------------
  const chartOrderStatistics = document.querySelector('#orderStatisticsChart'),
    orderChartConfig = {
      chart: {
        height: 165,
        width: 130,
        type: 'donut'
      },
      labels: ['Electronic', 'Sports', 'Decor', 'Fashion'],
      series: [85, 15, 50, 50],
      colors: [config.colors.primary, config.colors.secondary, config.colors.info, config.colors.success],
      stroke: {
        width: 5,
        colors: cardColor
      },
      dataLabels: {
        enabled: false,
        formatter: function (val, opt) {
          return parseInt(val) + '%';
        }
      },
      legend: {
        show: false
      },
      grid: {
        padding: {
          top: 0,
          bottom: 0,
          right: 15
        }
      },
      plotOptions: {
        pie: {
          donut: {
            size: '75%',
            labels: {
              show: true,
              value: {
                fontSize: '1.5rem',
                fontFamily: 'Public Sans',
                color: headingColor,
                offsetY: -15,
                formatter: function (val) {
                  return parseInt(val) + '%';
                }
              },
              name: {
                offsetY: 20,
                fontFamily: 'Public Sans'
              },
              total: {
                show: true,
                fontSize: '0.8125rem',
                color: axisColor,
                label: 'Weekly',
                formatter: function (w) {
                  return '38%';
                }
              }
            }
          }
        }
      }
    };
  if (typeof chartOrderStatistics !== undefined && chartOrderStatistics !== null) {
    const statisticsChart = new ApexCharts(chartOrderStatistics, orderChartConfig);
    statisticsChart.render();
  }

  // Income Chart - Area chart
  // --------------------------------------------------------------------
  const incomeChartEl = document.querySelector('#incomeChart'),
    incomeChartConfig = {
      series: [
        {
          data: [24, 21, 30, 22, 42, 26, 35, 29]
        }
      ],
      chart: {
        height: 215,
        parentHeightOffset: 0,
        parentWidthOffset: 0,
        toolbar: {
          show: false
        },
        type: 'area'
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        width: 2,
        curve: 'smooth'
      },
      legend: {
        show: false
      },
      markers: {
        size: 6,
        colors: 'transparent',
        strokeColors: 'transparent',
        strokeWidth: 4,
        discrete: [
          {
            fillColor: config.colors.white,
            seriesIndex: 0,
            dataPointIndex: 7,
            strokeColor: config.colors.primary,
            strokeWidth: 2,
            size: 6,
            radius: 8
          }
        ],
        hover: {
          size: 7
        }
      },
      colors: [config.colors.primary],
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
      grid: {
        borderColor: borderColor,
        strokeDashArray: 3,
        padding: {
          top: -20,
          bottom: -8,
          left: -10,
          right: 8
        }
      },
      xaxis: {
        categories: ['', 'Today', 'This Week', '', 'This Month', 'Remaining', '', 'Overtime'],
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false
        },
        labels: {
          show: true,
          style: {
            fontSize: '13px',
            colors: axisColor
          }
        }
      },
      yaxis: {
        labels: {
          show: false
        },
        min: 10,
        max: 50,
        tickAmount: 4
      }
    };
  if (typeof incomeChartEl !== undefined && incomeChartEl !== null) {
    const incomeChart = new ApexCharts(incomeChartEl, incomeChartConfig);
    incomeChart.render();
  }

  // Expenses Mini Chart - Radial Chart
  // --------------------------------------------------------------------
  const weeklyExpensesEl = document.querySelector('#expensesOfWeek'),
    weeklyExpensesConfig = {
      series: [65],
      chart: {
        width: 60,
        height: 60,
        type: 'radialBar'
      },
      plotOptions: {
        radialBar: {
          startAngle: 0,
          endAngle: 360,
          strokeWidth: '8',
          hollow: {
            margin: 2,
            size: '45%'
          },
          track: {
            strokeWidth: '50%',
            background: borderColor
          },
          dataLabels: {
            show: true,
            name: {
              show: false
            },
            value: {
              formatter: function (val) {
                return '$' + parseInt(val);
              },
              offsetY: 5,
              color: '#697a8d',
              fontSize: '13px',
              show: true
            }
          }
        }
      },
      fill: {
        type: 'solid',
        colors: config.colors.primary
      },
      stroke: {
        lineCap: 'round'
      },
      grid: {
        padding: {
          top: -10,
          bottom: -15,
          left: -10,
          right: -10
        }
      },
      states: {
        hover: {
          filter: {
            type: 'none'
          }
        },
        active: {
          filter: {
            type: 'none'
          }
        }
      }
    };
  if (typeof weeklyExpensesEl !== undefined && weeklyExpensesEl !== null) {
    const weeklyExpenses = new ApexCharts(weeklyExpensesEl, weeklyExpensesConfig);
    weeklyExpenses.render();
  }

  //START HERE YG GA TEMPLATE PPPPPP
  async function renderDepartmentAttendanceChart() {
    try {
      const response = await fetch('http://localhost:8000/dashboard/department-summary');
      if (!response.ok) throw new Error('Network response was not ok');

      const data = await response.json();
      const deptAttendanceEl = document.querySelector("#departmentAttendanceChart");

      if (!deptAttendanceEl || !Array.isArray(data)) return;

      const categories = data.map(item => item.department);
      const seriesData = data.map(item => item.present);

      const options = {
          chart: {
            type: 'bar',
            height: 350,
            animations: {
              enabled: true,
              easing: 'easeinout',
              speed: 800
            }
          },
          series: [{
            name: "Present",
            data: seriesData
          }],
          xaxis: {
            categories,
            labels: {
              style: {
                fontSize: '13px',
                colors: axisColor
              }
            }
          },
          colors: [config.colors.primary],
          fill: {
            opacity: 1,
            type: 'gradient',
            gradient: {
              shade: 'light',
              type: 'vertical',
              shadeIntensity: 0.3,
              inverseColors: false,
              opacityFrom: 1,
              opacityTo: 0.7,
              stops: [0, 80]
            }
          },
          plotOptions: {
            bar: {
              borderRadius: 12,
              startingShape: 'rounded',
              columnWidth: '40%',
              distributed: true
            }
          },
          dataLabels: {
            enabled: false
          },
          grid: {
            borderColor: borderColor,
          },
          tooltip: {
            theme: 'light',
            y: {
              formatter: val => `${val} hadir`
            }
          },
          legend: {
            labels: {
              colors: axisColor
            }
          }
        };


      new ApexCharts(deptAttendanceEl, options).render();
    } catch (error) {
      console.error('Error fetching department attendance data:', error);
    }
  }

  renderDepartmentAttendanceChart();

  async function loadAttendanceTrendChart() {
    try {
      const res = await fetch('http://localhost:8000/dashboard/attendance-trend');
      const data = await res.json();

      const dates = [...new Set(data.map(item => item.month))].sort();
      const statuses = [...new Set(data.map(item => item.status))];

      const series = statuses.map(status => ({
        name: status,
        data: dates.map(date => {
          const record = data.find(d => d.month === date && d.status === status);  
          return record ? record.count : 0;
        })
      }));

      const options = {
        chart: {
          type: 'bar',
          height: 350,
          stacked: true,
        },
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
        dataLabels: {
          enabled: false
        },
        series: series,
        xaxis: {
          categories: dates,
          labels: {
              style: {
                fontSize: '13px',
                colors: axisColor
              }
          }
        },
        legend: {
          labels: {
              colors: axisColor
            },
          position: 'top',
        },
        colors: [config.colors.primary, config.colors.info, config.colors.warning],
      };

      const chart = new ApexCharts(document.querySelector("#attendanceRateChart"), options);
      chart.render();

    } catch (error) {
      console.error("Error loading attendance trend chart:", error);
    }
  }

  // Panggil function-nya
  loadAttendanceTrendChart();

  async function loadWorkingHoursChart() {
  try {
    const response = await fetch('http://localhost:8000/dashboard/weekly-working-hours');
    const data = await response.json();

    const options = {
      chart: {
        type: 'area',
        height: 300
      },
      colors: [config.colors.primary],
      dataLabels: { 
        enabled: false 
      },
      stroke: {
        curve: 'smooth',
        width: 3,
      },
      markers: {
        size: 4,
        strokeWidth: 0,
        hover: { size: 6 },
      },
      xaxis: {
        categories: data.labels,
        labels: {
          style: {
            fontSize: '13px',
            colors: axisColor
          }
        }
      },
      tooltip: {
        y: {
          formatter: val => `${val.toFixed(2)} hours`
        }
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
      series: [
        {
          name: 'Working Hours',
          data: data.series
        }
      ]
    };

    const chart = new ApexCharts(document.querySelector('#weeklyWorkingHoursChart'), options);
    chart.render();
    } catch (error) {
      console.error('Failed to load working hours data:', error);
    }
  }
  loadWorkingHoursChart();

  async function loadMonthlyAttendanceChart() {
  const employeeId = sessionStorage.getItem('employee_id');
  if (!employeeId) {
    console.error('employee_id not found in sessionStorage');
    return;
  }

  try {
    const response = await fetch(`http://localhost:8000/dashboard/monthly-attendance/${employeeId}`);
    const data = await response.json();

    const options = {
      chart: {
        type: 'bar',
        height: 300,
        stacked: true
      },
      colors: [config.colors.purplecolor,config.colors.bluecolor, config.colors.skycolor ],
      series: data.series,
      xaxis: {
        categories: data.labels,
        labels: {
          style: {
            fontSize: '13px',
            colors: axisColor
          }
        }
      },
      legend: {
        position: 'top',
        horizontalAlign: 'center',
        labels: {
          colors: axisColor
        }
      },
        tooltip: {
          y: {
            formatter: val => `${val} days`
          }
        },
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
        dataLabels: {
          enabled: false
        }
    };

    const chart = new ApexCharts(document.querySelector('#monthlyAttendanceChart'), options);
    chart.render();

    } catch (error) {
      console.error('Failed to load monthly attendance data:', error);
    }
  }
  loadMonthlyAttendanceChart();

})();