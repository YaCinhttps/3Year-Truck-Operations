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
Since OR and WA have the exact same load count (7,338) but OR earns roughly $5.8M more, the revenue gap between the top states is driven more by revenue per load than by volume — worth checking total_revenue / load_count per state to confirm. The top 5 states (OR, CA, WA, TX, PA) together account for about 55% of total revenue across 18 states, which is a meaningful concentration but not an extreme one.   these states currently carry the most revenue, but that reflects where activity already is, not necessarily where the best growth opportunity is — expansion decisions would need cost, competition, and lane-profitability data this table doesn't show, not just revenue share.
Revenue is concentrated in a handful of states — OR, CA, WA, TX, and PA make up about 55% of total revenue. OR earns more per load than any other state ($5,289/load), and the follow-up dug into why: OR and WA run nearly identical distances (~2,220 miles), but OR is priced higher per mile ($2.43 vs $2.15) — about a 13% gap that carries straight through to actual revenue per mile. So it's a pricing difference, not a distance difference.

---

**Q2: Which customers generate the most revenue, and how concentrated is that revenue?**

> _Your answer / findings here_

| Customer | Total Loads | Total Revenue | % of Total Revenue |
|---|---|---|---|
| | | | |

**Insight:**

---

**Q3: Which routes are the most and least profitable, accounting for the rate structure vs. actual earnings?**

> _Your answer / findings here — note how you defined "profitable" for this question_

| Route | Base Rate/Mile | Actual Revenue/Mile | Variance |
|---|---|---|---|
| | | | |

**Insight:**

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


