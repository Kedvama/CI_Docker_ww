package com.NoviBackend.WalletWatch.stock;

import com.NoviBackend.WalletWatch.wallet.Wallet;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

import java.math.BigDecimal;

@Entity(name = "Stocks")
public class Stock {

    // Attributes
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private String stockName;

    @Column
    private BigDecimal value;

    @Column
    private Long quantity;

    @Column
    private BigDecimal buyLimit;

    @Column
    private BigDecimal sellLimit;

    @Column
    private String notations;

    @Column
    private BigDecimal percentageGoal;

    @Column
    private String action;

    @ManyToOne
    @JoinColumn(name="wallet_id", nullable = false)
    @JsonIgnore
    private Wallet wallet;

    // Constructor
    public Stock(){}

    public Stock(String stockName, BigDecimal value,
                 BigDecimal buyLimit, BigDecimal sellLimit,
                 String notations, BigDecimal percentageGoal,
                 Long quantity) {
        this.stockName = stockName;
        this.value = value;
        this.buyLimit = buyLimit;
        this.sellLimit = sellLimit;
        this.notations = notations;
        this.percentageGoal = percentageGoal;
        this.quantity = quantity;
    }

    public Stock(String stockName, BigDecimal value,
                 Long quantity, BigDecimal buyLimit,
                 BigDecimal sellLimit, String notations,
                 BigDecimal percentageGoal, String action) {

        this(stockName, value, buyLimit, sellLimit, notations, percentageGoal, quantity);
        this.action = action;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStockName() {
        return stockName;
    }

    public void setStockName(String stockName) {
        this.stockName = stockName;
    }

    public BigDecimal getValue() {
        return value;
    }

    public void setValue(BigDecimal value) {
        this.value = value;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getBuyLimit() {
        return buyLimit;
    }

    public void setBuyLimit(BigDecimal buyLimit) {
        this.buyLimit = buyLimit;
    }

    public BigDecimal getSellLimit() {
        return sellLimit;
    }

    public void setSellLimit(BigDecimal sellLimit) {
        this.sellLimit = sellLimit;
    }

    public String getNotations() {
        return notations;
    }

    public void setNotations(String notations) {
        this.notations = notations;
    }

    public BigDecimal getPercentageGoal() {
        return percentageGoal;
    }

    public void setPercentageGoal(BigDecimal percentageGoal) {
        this.percentageGoal = percentageGoal;
    }

    public Wallet getWallet() {
        return wallet;
    }

    public void setWallet(Wallet wallet) {
        this.wallet = wallet;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
}
