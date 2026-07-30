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

### 2. Sales / Operational Performance

**Q5: How has load volume trended month over month across the full 3-year period?**

I checked monthly load volume over three years — pretty flat, within 2% year over year, so this is a stable business, not a growth story. One thing caught my eye though: February was always the lowest month. But February also has fewer days, so I normalized to a per-day rate before trusting that — and the dip disappeared. Turned out to be a calendar artifact, not a real seasonal pattern.

**Insight:**
Turned out to be a calendar artifact, not a real seasonal pattern And It did not need to be flagged .
---
 
**Q6: Which days of the week see the most loads dispatched, and does that correlate with revenue?**

Load volume is essentially flat across all 7 days — the spread runs from 12,011 (Wednesday) to 12,544 (Tuesday), about 4%, and average revenue per load varies by under 1% across the whole week. With roughly 85,000 total loads spread across 7 days, a gap of a few hundred loads on any given day is within normal variation, not a meaningful operational signal — same lesson as the February check in Q5
 
| Weekday | Load Count | Total Revenue | Avg Revenue/Load |
|---|---:|---:|---:|
| Monday | 12,278 | $37,859,719.40 | $3,083.54 |
| Tuesday | 12,544 | $38,464,806.89 | $3,066.39 |
| Wednesday | 12,011 | $37,051,757.88 | $3,084.82 |
| Thursday | 12,296 | $37,784,185.70 | $3,072.88 |
| Friday | 12,152 | $37,402,517.64 | $3,077.89 |
| Saturday | 12,086 | $37,056,763.59 | $3,066.09 |
| Sunday | 12,043 | $36,906,049.19 | $3,064.52 |
 
**Insight:**
 
 there's no real weekday/weekend split here. Saturday and Sunday are not meaningfully lower than weekdays, which is somewhat unusual for a freight operation and worth stating as a finding on its own: there's no obvious slow day to plan staffing or capacity around — demand is evenly distributed across the full week.



---

---
 
**Q7: What does a typical load look like in value (median, quartiles, outliers)?**
 
| Q1 | Median | Q3 | Min | Max |
|---:|---:|---:|---:|---:|
| $1,443.22 | $2,827.98 | $4,323.16 | $125.93 | $8,125.22 |
 
**Insight:**
 
Load value shows a tight, well-behaved distribution — median $2,827.98 sits reasonably close to the average $3,073.71 (about 9% apart), and the maximum load value ($8,125.22) falls just under the standard 1.5×IQR outlier threshold ($8,643.07, calculated from IQR = Q3 − Q1 = $2,879.94), meaning there are no statistical outliers in the dataset at all. Combined with the flat weekday pattern from Q6, this reinforces the picture of a highly standardized, consistent freight operation rather than one with a mix of small and occasional massive shipments.
 
---

---

**Q8: Are there seasonal patterns — do certain months consistently outperform others across all 3 years?**

No meaningful seasonal pattern.
 
**Insight:**
 
Comparing every calendar month against itself across years (e.g. all three Januaries, all three Junes) and normalizing for actual days-in-month — including the 2024 leap year (Feb had 29 days that year) — shows load volume ranging from 75.77 to 78.96 loads/day across all 12 months, a spread of just 4.1% of the overall average (77.93 loads/day). Notably, once normalized, February is no longer the low point (that was a days-in-month artifact addressed in Q5) — December is the slight low instead, and even that gap is unremarkable. This is consistent with the flat weekly pattern in Q6 and the flat year-over-year trend in Q5: this is a highly stable, non-seasonal freight operation. No month or season warrants special staffing, capacity, or pricing adjustments based on this data.



---

### 3. Fleet & Driver Performance


---
 
**Q10: What's the average MPG by truck make/model, and is there a fleet-wide MPG trend over the 3 years?**
 
Fuel efficiency is uniform — both across truck makes and across time.
 
| Make | Avg MPG | Trip Count |
|---|---:|---:|
| Mack | 6.51 | 12,681 |
| Kenworth | 6.50 | 10,030 |
| Peterbilt | 6.50 | 14,699 |
| International | 6.50 | 15,450 |
| Freightliner | 6.50 | 13,660 |
| Volvo | 6.49 | 17,218 |
 
**Insight:**
 
Fuel efficiency is remarkably uniform across this fleet, both by truck make and over time. All six manufacturers average within 6.49-6.51 MPG of each other — a 0.02 MPG spread across trip counts ranging from ~10K to ~17K, ruling out small-sample noise as the explanation. The 3-year monthly trend shows the same flatness: MPG ranges from 6.47 to 6.53 with no meaningful upward or downward drift across 36 months (Jan 2022 = 6.51, Dec 2024 = 6.51). Combined with the flat patterns already found in load volume (Q5), weekday distribution (Q6), and seasonality (Q8), this reinforces that operations here are highly standardized — fuel efficiency isn't driven by which truck manufacturer is used or by fleet aging/turnover, and there's no efficiency trend to act on either positively or negatively.
 
---

**Q11: Which trucks have the highest maintenance cost per mile driven — older or newer vehicles?**

Contrary to the typical assumption, cost per mile does not increase with age — if anything, it trends slightly down.
 
| Truck Age | Avg Cost/Mile | Sample Size |
|---|---:|---:|
| 4 yrs | $0.040 | 1 |
| 5 yrs | $0.0367 | 18 |
| 6 yrs | $0.0360 | 10 |
| 7 yrs | $0.0391 | 11 |
| 8 yrs | $0.0382 | 17 |
| 9 yrs | $0.0364 | 14 |
| 10 yrs | $0.0336 | 11 |
| 11 yrs | $0.0330 | 10 |
 


**Insight:**
I expected older trucks to cost more to maintain per mile — that's the obvious assumption. But when I grouped by truck age, there was no upward trend at all. If anything, older trucks were slightly cheaper per mile, not more expensive. I checked whether older trucks were just driven less, but miles were roughly the same across every age group, so that wasn't it. My best guess is survivorship bias — trucks that got expensive to maintain probably got retired already, so the old trucks still in the fleet are the ones that held up well. I can't fully confirm that without retirement records, but it's a real counterintuitive finding worth flagging rather than forcing it to match the assumption I walked in with

---
 
**Q12: Is there a relationship between truck utilization and maintenance frequency/cost?**
 
No meaningful relationship — maintenance appears schedule-driven, not wear-driven.
 
| Utilization Quartile | Avg Miles | Avg Maint. Count | Avg Maint. Cost | Avg Cost/Mile |
|---|---:|---:|---:|---:|
| Q1 (lowest) | 1,236,356 | 25.3 | $48,989 | $0.0396 |
| Q2 | 1,287,703 | 24.6 | $46,156 | $0.0359 |
| Q3 | 1,317,668 | 22.8 | $45,102 | $0.0342 |
| Q4 (highest) | 1,364,195 | 24.3 | $47,988 | $0.0351 |
 
**Insight:**
 
I expected trucks driven more to need more maintenance — that's the intuitive assumption. So I bucketed all 120 trucks into utilization quartiles by total miles driven and compared maintenance frequency and cost across buckets. There's basically no relationship — correlation between miles driven and maintenance count is -0.042, and miles vs. total cost is +0.014, both essentially zero. The busiest trucks (Q4) aren't maintained more often or more expensively than the least-used trucks (Q1). Combined with Q11's finding that truck age doesn't drive maintenance cost either, this suggests maintenance in this fleet is likely scheduled on a fixed interval rather than driven by actual wear or usage. A useful follow-up outside this analysis: does `maintenance_records` distinguish scheduled preventive service from unscheduled repairs? That distinction would explain why neither age nor mileage shows the expected relationship.
 
---

### 4. Logistics & Delivery

**Q13: What's the overall on-time delivery rate, and how does it vary by facility?**
 
Only 55.67% of deliveries are on time company-wide — a systemic issue, not a facility-specific one.
 
| Facility | Total Events | On-Time % |
|---|---:|---:|
| FAC00048 (lowest) | 3,384 | 53.04% |
| FAC00012 | 3,278 | 53.42% |
| FAC00034 | 3,414 | 53.46% |
| ... | *(46 more facilities, all between 53-58% — see full CSV in data/analysis/)* | |
| FAC00022 | 3,419 | 57.71% |
| FAC00001 (highest) | 3,279 | 58.28% |
| **All facilities combined** | **170,820** | **55.67%** |
 
**Insight:**
 
The overall on-time delivery rate across all 50 facilities and 170,820 delivery events is 55.67% — meaning nearly half of every delivery in this operation is late. That tight, consistent spread is itself the finding: this isn't a few underperforming facilities dragging down the average ,this is a case where the underlying number itself (55.67% on-time) is the headline finding, and it's a real operational issue worth flagging to stakeholders regardless of which facility they operate.
 
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


