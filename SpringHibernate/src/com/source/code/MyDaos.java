package com.source.code;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class MyDaos {
	@Autowired
	private SessionFactory sessionFactory;

	public Document getById(int id) {
		return (Document) sessionFactory.getCurrentSession().get(
				Document.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Document> searchDocuments(String query, String search) {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Document.class);
		criteria.add(Restrictions.ilike(search, query + "%"));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	public List<Document> getAllDocuments() {
		Criteria criteria = sessionFactory.getCurrentSession().createCriteria(
				Document.class);
		return criteria.list();
	}

	public void save(Document document) {
		sessionFactory.getCurrentSession().save(document);
	}

	public void register(Join object) {
		 sessionFactory.getCurrentSession().save(object);
	}

	public void update(Document document) {
		sessionFactory.getCurrentSession().merge(document);
	}

	public void delete(int id) {
		Document c = getById(id);
		sessionFactory.getCurrentSession().delete(c);
	}

	public Join login(String username, String password) {
		return (Join) sessionFactory
				.getCurrentSession()
				.createQuery(
						"from Join j where j.name=:name and j.password=:pass")
				.setParameter("name", username).setParameter("pass", password)
				.uniqueResult();
	}

}
