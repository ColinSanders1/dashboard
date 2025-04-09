# ⚾ OFP Calculator for Pitchers

This tool provides a flexible and customizable system for evaluating the **Overall Future Potential (OFP)** of amateur and professional pitchers using the 20–80 scouting scale. It supports different weighting systems and allows separate evaluation logic for **Right-Handed Pitchers (RHP)** and **Left-Handed Pitchers (LHP)**.

---

## 🔍 Overview

The OFP Calculator is built in **Google Sheets** and enhanced with logic and helper functions in **R**. It is designed for use by amateur scouts, analysts, and player development staff who want a more transparent and consistent framework for projecting pitchers.

---

## 🎯 Features

- ✅ Inputs based on traditional scouting grades (20–80 scale)
- ✅ Supports different weightings for RHP vs LHP
- ✅ Automatically ranks players based on unrounded OFP
- ✅ Rounds OFP to the nearest multiple of 5 for presentation
- ✅ Built-in formulas for computing OFP directly in Google Sheets
- ✅ Companion R scripts for batch processing or analysis

---

## 🛠️ Tech Stack

- **Google Sheets** – Front-end for input and live calculations
- **R** – Optional scripting for importing/exporting data and advanced logic
- **tidyverse** – Data wrangling
- **googlesheets4** (optional) – For syncing Google Sheets data in R

---

## 📈 How It Works

1. **Input** scouting grades into the sheet.
2. **Weightings** for each trait (e.g., FB, SL, CB, CH, CMD, ATH) are customized for RHP and LHP.
3. **OFP is calculated** as a weighted average.
4. **OFP is rounded** to the nearest 5 (e.g., 52 becomes 50, 63 becomes 65).
5. **Final ranking** is based on unrounded OFP, preserving precision in evaluation.

---

## 🧮 Formula Snapshot

Example (simplified):

