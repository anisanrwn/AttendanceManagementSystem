        async function fetchAttendance() {
            const employeeId = sessionStorage.getItem('employee_id');

            try {
                const response = await fetch(`http://localhost:8000/attendance/recap?employee_id=${employeeId}`);
                if (!response.ok) throw new Error("Failed to fetch attendance data");
                
                const data = await response.json();
                const attendance = data.attendance || [];
                
                let totalHours = 0;
                const monthlyAttendance = {
                    "Jan": 0,
                    "Feb": 0,
                    "Mar": 0,
                    "Apr": 0,
                    "May": 0,
                    "Jun": 0,
                    "Jul": 0,
                    "Aug": 0,
                    "Sep": 0,
                    "Oct": 0,
                    "Nov": 0,
                    "Dec": 0
                };

                attendance.forEach(record => {
                    const date = new Date(record.date);
                    const month = date.toLocaleString('default', { month: 'short' });
                    const hours = record.totalHours || 0;

                    // Calculate total hours
                    totalHours += hours;

                    // Count monthly attendance
                    monthlyAttendance[month] += 1;
                });

                // Render Working Hours Chart
                renderWorkingHoursChart(totalHours);

                // Render Monthly Attendance Chart
                renderMonthlyAttendanceChart(monthlyAttendance);

            } catch (error) {
                console.error("Error fetching attendance:", error);
            }
        }
function renderWorkingHoursChart(totalHours) {
        const workingHoursChartEl = document.querySelector('#workingHoursChart');
        const options = {
            series: [totalHours],
            chart: {
                height: 350,
                type: 'radialBar',
                sparkline: {
                    enabled: false
                }
            },
            plotOptions: {
                radialBar: {
                    startAngle: -120,
                    endAngle: 120,
                    hollow: {
                        size: '60%',
                        background: '#fff',
                        margin: 5
                    },
                    track: {
                        background: 'rgba(67, 97, 238, 0.1)',
                        strokeWidth: '60%',
                        margin: 3,
                        dropShadow: {
                            enabled: true,
                            top: 1,
                            left: 0,
                            blur: 4,
                            opacity: 0.15
                        }
                    },
                    dataLabels: {
                        name: {
                            color: '#6b7280',
                            fontSize: '14px',
                            fontWeight: '600',
                            offsetY: -10
                        },
                        value: {
                            color: '#3f37c9',
                            fontSize: '28px',
                            fontWeight: '700',
                            offsetY: 5
                        },
                        total: {
                            show: true,
                            label: 'Total Hours',
                            color: '#6b7280',
                           formatter: function(w) {
                            const raw = w.globals.seriesTotals.reduce((a, b) => a + b, 0);
                            const cleaned = raw.replace(/^0+(?!$)/, ''); // Hapus 0 di depan, kecuali kalau hasilnya cuma 0
                            return cleaned + 'h';
                        }

                        }
                    }
                }
            },
            fill: {
                type: 'pattern',
                pattern: {
                    style: 'circles', // <-- INI YANG BIKIN ADA GARIS-GARIS KECILNYA!
                    width: 6,
                    height: 6,
                    strokeWidth: 2,
                    stroke: '#4361ee'
                }
            },
            stroke: {
                lineCap: 'round',
                width: 0
            },
            colors: ['#4361ee'],
            labels: ['Working Progress'],
            markers: {
                size: 0
            }
        };
        const workingHoursChart = new ApexCharts(workingHoursChartEl, options);
        workingHoursChart.render();
    }

        function renderMonthlyAttendanceChart(monthlyAttendance) {
            const monthlyAttendanceChartEl = document.querySelector('#monthlyAttendanceChart');
            const options = {
                series: [{
                    name: 'Attendance Days',
                    data: Object.values(monthlyAttendance),
                }],
                chart: {
                    type: 'bar',
                    height: '100%',
                    toolbar: {
                        show: false
                    },
                    zoom: {
                        enabled: false
                    }
                },
                plotOptions: {
                    bar: {
                        borderRadius: 8,
                        horizontal: false,
                        columnWidth: '55%',
                        endingShape: 'rounded'
                    },
                },
                dataLabels: {
                    enabled: false
                },
                stroke: {
                    show: true,
                    width: 2,
                    colors: ['transparent']
                },
                colors: ['#4361ee', '#3f37c9', '#4cc9f0'],
                xaxis: {
                    categories: Object.keys(monthlyAttendance),
                    axisBorder: {
                        show: false
                    },
                    axisTicks: {
                        show: false
                    },
                    labels: {
                        style: {
                            colors: '#6b7280',
                            fontSize: '12px',
                            fontFamily: 'Public Sans, sans-serif',
                            fontWeight: 400,
                        },
                    },
                },
                yaxis: {
                    labels: {
                        style: {
                            colors: '#6b7280',
                            fontSize: '12px',
                            fontFamily: 'Public Sans, sans-serif',
                            fontWeight: 400,
                        },
                        formatter: function (value) {
                            return Math.floor(value);
                        }
                    }
                },
                fill: {
                    opacity: 1,
                    type: 'gradient',
                    gradient: {
                        shade: 'light',
                        type: 'vertical',
                        shadeIntensity: 0.3,
                        inverseColors: false,
                        opacityFrom: 0.8,
                        opacityTo: 0.2,
                        stops: [0, 80]
                    }
                },
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return val + " days"
                        }
                    },
                    style: {
                        fontSize: '12px',
                        fontFamily: 'Public Sans, sans-serif',
                    },
                },
                grid: {
                    borderColor: '#f1f1f1',
                    strokeDashArray: 5,
                    yaxis: {
                        lines: {
                            show: true,
                        }
                    },
                    padding: {
                        top: 0,
                        right: 20,
                        bottom: 0,
                        left: 20
                    },
                }
            };
            const monthlyAttendanceChart = new ApexCharts(monthlyAttendanceChartEl, options);
            monthlyAttendanceChart.render();
        }

        // Call the function to fetch attendance data
        fetchAttendance();