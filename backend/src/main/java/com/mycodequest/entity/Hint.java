package com.mycodequest.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "hints")
public class Hint {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "problem_id")
    private Long problemId;

    private Integer layer;

    @Column(nullable = false)
    private String name;

    private String icon;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "hp_cost")
    private Integer hpCost;

    @Column(name = "order_num")
    private Integer orderNum;

    public Hint() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getProblemId() { return problemId; }
    public void setProblemId(Long problemId) { this.problemId = problemId; }
    public Integer getLayer() { return layer; }
    public void setLayer(Integer layer) { this.layer = layer; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Integer getHpCost() { return hpCost; }
    public void setHpCost(Integer hpCost) { this.hpCost = hpCost; }
    public Integer getOrderNum() { return orderNum; }
    public void setOrderNum(Integer orderNum) { this.orderNum = orderNum; }
}