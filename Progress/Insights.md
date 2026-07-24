# 🚚 3-Year Truck Operations — SQL Business Analysis

This phase covers business analysis of the truck operations dataset using PostgreSQL. Questions span revenue, sales performance, fleet/driver performance, logistics, and safety.

---


## 📊 Business Questions & Key Findings

### 1. Revenue & Profitability

**Q1: What is total revenue, and how is it distributed across the 5 markets/states you're operating in?**

 The First 5 states With Most Revenue Are OR ,CA, WA ,TX, PA

| Market/State | Orders | Revenue | % of Total | Revenue/Load |
|---|---:|---:|---:|---:|
| OR | 7,338 | $38,813,235.77 | 14.78% | $5,289.35 |
| CA | 8,948 | $33,842,249.15 | 12.89% | $3,782.10 |
| WA | 7,338 | $32,975,646.45 | 12.56% | $4,493.82 |
| TX | 7,277 | $21,997,706.09 | 8.38% | $3,022.91 |
| PA | 6,100 | $15,943,359.44 | 6.07% | $2,613.67 |
| NC | 4,396 | $14,928,979.60 | 5.69% | $3,396.04 |
| IN | 5,810 | $13,915,630.59 | 5.30% | $2,395.12 |
| CO | 5,863 | $13,110,696.76 | 4.99% | $2,236.18 |
| MO | 5,889 | $13,031,953.32 | 4.96% | $2,212.93 |
| NY | 4,516 | $12,173,410.05 | 4.64% | $2,695.62 |
| MI | 2,915 | $10,894,484.44 | 4.15% | $3,737.39 |
| OH | 2,973 | $8,647,093.43 | 3.29% | $2,908.54 |
| MN | 4,424 | $7,716,711.81 | 2.94% | $1,744.28 |
| FL | 2,924 | $7,325,190.52 | 2.79% | $2,505.20 |
| NV | 1,479 | $6,236,094.68 | 2.38% | $4,216.43 |
| GA | 2,826 | $5,658,154.98 | 2.16% | $2,002.18 |
| TN | 2,938 | $3,639,840.41 | 1.39% | $1,238.88 |
| IL | 1,456 | $1,675,362.80 | 0.64% | $1,150.66 |

**Insight:**
"I was looking at revenue by state and found the top five states drive over half our revenue. But the interesting part was comparing Oregon and Washington — same exact number of loads, yet Oregon brought in almost six million more. So I checked the rate data, and it turned out Oregon's freight was priced about thirteen percent higher per mile, even though trip distances were nearly identical. So it wasn't volume driving the gap, it was pricing. The takeaway: don't assume more revenue means 'do more there' — sometimes it means you're already pricing well, and the real opportunity is bringing weaker states up to that level."

---


**Q2: Which customers generate the most revenue, and how concentrated is that revenue?**
 
Across ~200 customers, revenue share ranges narrowly from 0.41% to 0.59% of total — no single customer or small group dominates.
 
| Customer ID | Customer Name | Total Loads | Total Revenue | % of Total |
|---|---|---:|---:|---:|
| CUST00200 | XYZ Foods | 476 | $1,544,419.81 | 0.59% |
| CUST00181 | Superior Group | 497 | $1,542,321.02 | 0.59% |
| CUST00077 | Metro Group | 487 | $1,521,982.07 | 0.58% |
| CUST00097 | National Wholesale | 470 | $1,487,129.31 | 0.57% |
| CUST00122 | Metro Foods | 463 | $1,483,188.90 | 0.56% |
| CUST00028 | First Group | 476 | $1,481,527.84 | 0.56% |
| CUST00110 | Continental Group | 481 | $1,479,584.73 | 0.56% |
| CUST00101 | United Corp | 460 | $1,477,854.32 | 0.56% |
| CUST00124 | First Supply Chain | 454 | $1,472,131.31 | 0.56% |
| CUST00196 | XYZ Logistics | 483 | $1,471,132.90 | 0.56% |
| ... | *(~185 more customers, revenue declining gradually — see full CSV in data/analysis/)* | | | |
| CUST00156 | First Logistics | 382 | $1,128,763.05 | 0.43% |
| CUST00149 | First Group | 400 | $1,078,045.01 | 0.41% |
 
**Insight:**
 
"After that, I checked whether we had the same concentration risk at the customer level — like, are we dependent on a few big accounts. Turns out no. Across two hundred customers, every single one sat between roughly zero-point-four and zero-point-six percent of total revenue — no cliff, nobody standing out. So unlike the state-level picture, the customer base is genuinely diversified, which is a good sign — losing any one account wouldn't meaningfully hurt the business.

---


**Q3: Which routes are the most and least profitable, accounting for the rate structure vs. actual earnings?**
 
Every one of the 58 routes underperformed its posted `base_rate_per_mile` — no route came in above rate. The gap is small (roughly -2.2% to -3.2%) but strikingly consistent across all routes regardless of price point, distance, or fuel surcharge.
 
| Route ID | Origin | Destination | Base Rate/Mile | Fuel Surcharge | Actual Rev/Mile | Variance | Variance % |
|---|---|---|---:|---:|---:|---:|---:|
| RTE00046 | Columbus | Los Angeles | $2.74 | 22.00% | $2.65 | -$0.09 | -3.22% |
| RTE00038 | Las Vegas | Kansas City | $2.71 | 24.00% | $2.62 | -$0.09 | -3.16% |
| RTE00011 | New York | Columbus | $1.69 | 24.00% | $1.64 | -$0.05 | -3.14% |
| RTE00058 | Kansas City | Indianapolis | $2.27 | 19.00% | $2.20 | -$0.07 | -3.14% |
| RTE00045 | Charlotte | Memphis | $2.33 | 23.00% | $2.26 | -$0.07 | -3.12% |
| ... | *(~48 more routes, variance holding steady in the -2.2% to -3.2% band — see full CSV in data/analysis/)* | | | | | | |
| RTE00010 | New York | Philadelphia | $1.61 | 17.00% | $1.57 | -$0.04 | -2.28% |
| RTE00016 | Philadelphia | Seattle | $2.50 | 17.00% | $2.44 | -$0.06 | -2.21% |
 
**Insight:**
 
Every route earns slightly less than its posted rate, but the uniformity of the gap (a tight ~1-point band across all 58 routes) rules out a simple "some routes are underperforming" story — this looks systemic. First hypothesis tested was the fuel surcharge (`fuel_surcharge_rate`), on the theory that actual revenue might be calculated net of surcharge while `base_rate_per_mile` isn't. That was ruled out directly: routes with similar surcharge rates show meaningfully different variance, and vice versa (e.g. RTE00043 and RTE00047 both carry a 16% surcharge but land at -3.09% and -2.90% variance respectively) — no real correlation.

---

**Q4: Is there a relationship between contract type and average revenue per load?**

> _Your answer / findings here_

| Contract Type | Avg Revenue/Load | Load Count |
|---|---|---|
| | | |

**Insight:**

---

### 2. Sales / Operational Performance

**Q5: How has load volume trended month over month across the full 3-year period?**

> _Your answer / findings here_

**Insight:**

---

**Q6: Which days of the week see the most loads dispatched, and does that correlate with revenue?**

> _Your answer / findings here_

| Weekday | Load Count | Total Revenue | Avg Revenue/Load |
|---|---|---|---|
| | | | |

**Insight:**

---

**Q7: What does a typical load look like in value (median, quartiles, outliers)?**

> _Your answer / findings here_

| Q1 | Median | Q3 | Min | Max |
|---|---|---|---|---|
| | | | | |

**Insight:**

---

**Q8: Are there seasonal patterns — do certain months consistently outperform others across all 3 years?**

> _Your answer / findings here — note how you separated "real seasonality" from noise_

**Insight:**

---

### 3. Fleet & Driver Performance

**Q9: Which drivers generate the most revenue per mile driven, and is that correlated with tenure?**

> _Your answer / findings here_

| Driver | Tenure (months) | Revenue/Mile | Total Miles |
|---|---|---|---|
| | | | |

**Insight:**

---

**Q10: What's the average MPG by truck make/model, and is there a fleet-wide MPG trend over the 3 years?**

> _Your answer / findings here_

| Make/Model | Avg MPG | Trip Count |
|---|---|---|
| | | |

**Insight:**

---

**Q11: Which trucks have the highest maintenance cost per mile driven — older or newer vehicles?**

> _Your answer / findings here — note how you defined "older/newer"_

| Truck | Age (years) | Cost/Mile | Total Maintenance Cost |
|---|---|---|---|
| | | | |

**Insight:**

---

**Q12: Is there a relationship between truck utilization and maintenance frequency/cost?**

> _Your answer / findings here_

**Insight:**

---

### 4. Logistics & Delivery

**Q13: What's the overall on-time delivery rate, and how does it vary by facility?**

> _Your answer / findings here_

| Facility | Total Events | On-Time % |
|---|---|---|
| | | |

**Insight:**

---

**Q14: Is there a relationship between detention time and on-time delivery outcomes?**

> _Your answer / findings here_

**Insight:**

---

**Q15: Which routes have the most trip volume, and do high-volume routes have better or worse on-time performance?**

> _Your answer / findings here_

| Route | Trip Volume | On-Time % |
|---|---|---|
| | | |

**Insight:**

---

**Q16: How does idle time vary by driver — are some drivers consistently more efficient than others?**

> _Your answer / findings here_

| Driver | Avg Idle Hours/Trip | Trip Count |
|---|---|---|
| | | |

**Insight:**

---

### 5. Safety

**Q17: What's the overall safety incident rate (per 1,000 trips or per million miles)?**

> _Your answer / findings here — note which denominator you chose and why_

**Insight:**

---

**Q18: Are incidents concentrated among certain drivers, or spread evenly across the fleet?**

> _Your answer / findings here_

| Driver | Incident Count | Total Trips | Incident Rate |
|---|---|---|---|
| | | | |

**Insight:**

---

**Q19: What proportion of incidents are marked preventable, and does that vary by driver tenure?**

> _Your answer / findings here_

| Tenure Bucket | Total Incidents | Preventable % |
|---|---|---|
| | | |

**Insight:**

---

**Q20: Is there a relationship between recent maintenance activity and safety incidents?**

> _Your answer / findings here — note how you defined "recent maintenance"_

**Insight:**

---

## 🔑 Summary of Key Business Insights

1.
2.
3.
4.
5.

---


